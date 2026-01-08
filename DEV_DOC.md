Set up the environment from scratch (prerequisites, configuration files, se-
crets)

Prerequisites

   • Docker
   • Docker-Compose
   • Create a file .env in srcs repository  

            EXEMPLE
    
        DB_NAME = mariadb
        DB_USER = userdb
        DB_PASSWORD = passworddb
        DB_ROOT_PASSWORD = rootpassworddb

        WP_URL = login.42.fr
        WP_TITLE =  title
        WP_ADMIN =  admin
        WP_ADMIN_PASSWORD =  passwordadmin 
        WP_ADMIN_EMAIL =  admin@email.com

        WP_USER = wpuser
        WP_USER_PASSWORD = passwordwp  
        WP_USER_EMAIL = wpuser@email.com

    • make


Setup

       • Dockerfile NGINX :

            # Use Debian bookworm as the base image
            FROM debian:bookworm

            # Update the package list install NGINX vim curl openssl And Create directory for SSL certificates 
            apt update -y && apt install nginx vim curl -y && mkdir -p /etc/nginx/ssl && apt install openssl -y
           
            #Create SSL keys & certificates
            RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pgiroux.42.fr/UID=pgiroux"

            # Create directory for NGINX run files
            RUN mkdir -p /var/run/nginx

            # Copy the NGINX configuration file to the container
            COPY ./conf/nginx.conf /etc/nginx/nginx.conf
            
            # Set permissions for the web root directory and Change ownership of the web root directory to www-data
            RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html
    
            # Start NGINX in the foreground
            CMD ["nginx", "-g", "daemon off;"]


        • Config file NGINX :

            # Define the user under which the NGINX worker processes will run
            user www-data;

            # Define the location of the process ID file for NGINX
            pid /run/nginx.pid;

            # Include additional configuration files from the modules-enabled directory
            include /etc/nginx/modules-enabled/*.conf;
           
            # Configure the event processing model
            events {
                # Set the maximum number of simultaneous connections that can be handled by a worker process
                 worker_connections 1024;
                   }

            # Define HTTP server settings
            http {
            # Define the server block for handling HTTPS traffic
                server {
                     # Listen on port 443 for both IPv4 and IPv6, with SSL enabled
                     listen 443 ssl;
                     listen [::]:443 ssl;
                    # Define the supported SSL/TLS protocols
                    ssl_protocols TLSv1.2 TLSv1.3;
                    # Specify the path to the SSL certificate
                    ssl_certificate /etc/nginx/ssl/inception.crt;
                    # Specify the path to the SSL certificate key
                    ssl_certificate_key /etc/nginx/ssl/inception.key;
                    # Set the root directory for the web server
                    root /var/www/html/wordpress;
                    # Define the server's hostname
                    server_name pgiroux.42.fr;
                    # Define the default files to serve
                    index index.php index.html index.htm index.nginx-debian.html;
                    # Configure the handling of requests to the root URL
                    location / {
                        # Include MIME types configuration
                        include /etc/nginx/mime.types;
                        # Include additional site configuration files
                        include /etc/nginx/sites-available/*.conf;
                        # Attempt to serve the requested URI, or return a 404 error if not found
                        try_files $uri $uri/ =404;
                                }
                    # Configure the handling of PHP files
                    location ~ \.php$ {
                        # Define the address and port of the FastCGI server
                        fastcgi_pass wordpress:9000;
                        # Split the path information for PHP files
                        fastcgi_split_path_info ^(.+\.php)(/.+)$;
                        # Define the script filename parameter for FastCGI
                        fastcgi_param SCRIPT_FILENAME $request_filename;
                        # Include the FastCGI parameters
                        include fastcgi_params;
                        # Indicate that HTTPS is being used
                        fastcgi_param HTTPS on;
                                      }
                    # Define the supported SSL/TLS protocols
                    ssl_protocols TLSv1.2 TLSv1.3;
                    # Specify the path to the SSL certificate
                    ssl_certificate /etc/nginx/ssl/inception.crt;
                    # Specify the path to the SSL certificate key
                    ssl_certificate_key /etc/nginx/ssl/inception.key;
                    # Define the location of the access log
                    access_log /var/log/nginx/access.log;
                    # Define the location of the error log
                    error_log /var/log/nginx/error.log;
                    # Enable gzip compression
                    gzip on;
                      }
                }


        • Dockerfile MariaDB

            # Use Debian bookworm as the base image
            FROM debian:bookworm
            # Install MariaDB and other dependencies
            RUN apt update -y && apt install -y mariadb-server mariadb-client procps
            # Copy the MariaDB configuration file to the container
            COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
            # Create directories for MariaDB runtime files and data and Set ownership and permissions for the MariaDB directories
            RUN mkdir -p /var/run/mysqld  /var/lib/mysql && chown -R mysql:mysql /var/run/mysqld/ /var/lib/mysql/ && chmod -R 755 /var/run/mysqld/ /var/lib/mysql/
            # Expose port 3306 for MariaDB
            EXPOSE 3306
            # Copy the initialization script to the container
            COPY ./conf/init.sh .
            # Make the initialization script executable
            RUN chmod +x ./init.sh  
            # Set the entry point to the initialization script
            ENTRYPOINT ["bash", "./init.sh"]

        • Config File MariaDB

            # MariaDB Server configuration
            [server]
            # MariaDB Database configuration
            [mysqld]
            # The user under which the MariaDB server will run
            user = mysql
            # The port on which MariaDB will listen for incoming connections
            port = 3306
            # Specifies that all IP addresses on the network can connect
            bind-address        = 0.0.0.0
            # The base directory for the MariaDB installation
            basedir = /usr
            # The directory where the MariaDB database files are stored
            datadir = /var/lib/mysql
            # The file that contains the process ID of the MariaDB server
            pid-file = /var/run/mysqld/mysqld.pid
            # The socket file used for local connections to MariaDB
            socket = /var/run/mysqld/mysqld.sock
            # Enable networking for MariaDB (allow connections over the network)
            skip_networking = off
            # The maximum size of a packet that can be sent or received by MariaDB
            max_allowed_packet = 64M
        
        • Script MariaDB :

            # Specifies that the script should be executed using the Bash shell
            #!/bin/bash
            # Exit immediately if any command returns a non-zero status
            set -e
            # Defines the directory where MariaDB data is stored
            DATADIR="/var/lib/mysql"
            # Checks if the MariaDB system database directory does not exist and initializes the MariaDB data directory if it has not been initialized yet
            if [ ! -d "$DATADIR/mysql" ]; then
            mysql_install_db --user=mysql --datadir="$DATADIR" > /dev/null
            fi
            # Starts the MariaDB server in the background without network access and stores the process ID of the MariaDB server
            mysqld --user=mysql --datadir="$DATADIR" --skip-networking & pid=$!
            # Loop 60sec, Checks if MariaDB is ready to accept connections and sleep 1sec
            for i in $(seq 1 60); do
            if mysqladmin ping --silent; then break; fi
            sleep 1
            done
            # Final check to ensure MariaDB has started successfully
            if ! mysqladmin ping --silent; then
            echo "MariaDB ne démarre pas."
            exit 1
            # Log into MariaDB as root and create the database and the user
            fi
            mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" || true
            mysql -uroot -p"${DB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
            mysql -uroot -p"${DB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
            mysql -uroot -p"${DB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%'; FLUSH PRIVILEGES;"
            # Shut down the MariaDB service gracefully
            mysqladmin -uroot -p"${DB_ROOT_PASSWORD}" shutdown
            # Start the MariaDB server safely, allowing recovery and loggin
            exec mysqld --user=mysql --datadir="$DATADIR" --bind-address=0.0.0.0

        • Dockerfile Wordpress :

            # Use Debian bookworm as the base image
            FROM debian:bookworm
            # Update qnd install PHP 8.2 FPM qnd mysql
            RUN apt update -y && apt install -y wget php8.2 php-fpm php-mysql
            # Download and install WP-CLI (WordPress Command Line Interface)
            RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar  && mv wp-cli.phar /usr/local/bin/wp
            # Install MySQL client
            RUN apt update -y && apt install -y default-mysql-client mariadb-clien
            # Download WordPress archive and extract it to /var/www/html directory and rm wordpress-6.8.tar.gz
            RUN wget https://wordpress.org/wordpress-6.8.tar.gz -P /var/www/html && cd /var/www/html && tar -xzf /var/www/html/wordpress-6.8.tar.gz && rm /var/www/html/wordpress-6.8.tar.gz
            # Set permissions for web server to read and execute files in the web root directory
            RUN chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/* 
            # Expose PHP-FPM port 9000
            EXPOSE 9000
            # Copy script for WordPress setup
            COPY ./conf/wpscript.sh .
            RUN chmod +x ./wpscript.sh
            # Copy custom PHP-FPM configuration file
            COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
            # Set entry point to run the WordPress setup script
            ENTRYPOINT ["bash", "./wpscript.sh"]

        • Config File Wordpress :

        # PHP-FPM configuration for the www pool
        [www]
        # Set the user and group under which PHP-FPM will run
        user = www-data
        group = www-data
        # Specify the address and port on which PHP-FPM will listen for connections
        listen = 9000
        listen.owner = www-data
        listen.group = www-data
        # Configure PHP-FPM process manager settings
        pm = dynamic
        pm.max_children = 5
        pm.start_servers = 2
        pm.min_spare_servers = 1
        pm.max_spare_servers = 3
        pm.max_requests = 100
        # Do not clear environment variables in FPM workers
        clear_env = no

        • Script Wordpress :
        
        #!/bin/bash
        sleep 10
        # Change directory to WordPress installation directory
        cd /var/www/html/wordpress
        # Check if wp-config.php file exists
        if [ ! -f wp-config.php ]; then
	    echo "CREATING CONFIG .... !\n"
	    wp config create --allow-root \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_PASSWORD} \
		--dbhost=mariadb \
		--path='/var/www/html/wordpress' \
		--url=https://${WP_URL}
        # Use WP-CLI to install WordPress with specified settings
        wp core install	--allow-root \
		--path='/var/www/html/wordpress' \
		--url=https://${WP_URL} \
		--title=${WP_TITLE} \
    	--admin_user="${WP_ADMIN}" \
	    --admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}"
        # Use WP-CLI to create additional user with specified role and credentials
    wp user create \
	    "${WP_USER}" "${WP_USER_EMAIL}" \
	    --role=author \
	    --user_pass="${WP_USER_PASSWORD}" --allow-root
        # Flush the cache using WP-CLI
        wp cache flush --allow-root
        echo "wp-config created successfully!"
        fi
        # Check if /run/php directory exists, if not, create it
        if [ ! -d /run/php ]; then
        mkdir /run/php;
        fi  
        # Start the PHP FastCGI Process Manager (FPM) for PHP version 7.4 in the foreground
        exec /usr/sbin/php-fpm7.4 -F -R

Build and launch the project using the Makefile and Docker Compose
    To build:

        make
    or
        docker-compose up --build

    To clean up:

        make clean
    or
        docker-compose down -v

    or

        make prune
    or
        docker system prune -af



Use relevant commands to manage the containers and volumes

    To see dockers:
        docker ps

    To see images:
        docker images

    To see networks:
        docker network ls

    To check volumes:
        docker volume inspect <volume_name>


Identify where the project data is stored and how it persists

All the data is stored the docker volumes (docker-compose.yml)


