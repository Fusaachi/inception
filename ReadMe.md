DOCKER


Docker est à la fois une bibliothèque et  une plateforme logicielles permettant de faire tourner certaines applications dans des conteneurs
Docker permet d'empaqueter une application et ses dépendances dans un conteneur isolé qui peut être exécuté sur n'importe quel serveur.


1. Conteneurisation : 

Contrairement à la virtualisation traditionnelle qui utilise des machines virtuelles (VMs) et nécessite un hyperviseur pour émuler le matériel, Docker utilise des conteneurs. Les conteneurs partagent le noyau du système d'exploitation hôte, ce qui les rend beaucoup plus légers et rapides à démarrer.

2. Images Docker :

Une image Docker est un instantané ou un plan des bibliothèques et des dépendances requises dans un conteneur pour qu'une application puisse s'exécuter.

3. Conteneurs Docker :

Un conteneur est une instance d'une image Docker. C'est un environnement d'exécution isolé qui exécute une application. Les conteneurs peuvent être démarrés, arrêtés, déplacés et supprimés de manière flexible, facilitant le déploiement et la gestion des applications.

4. Docker Engine :

Docker Engine est une technologie de conteneurisation open source permettant de créer et de conteneuriser vos applications.
L'interface de ligne de commande (CLI) utilise les API Docker pour contrôler le démon Docker ou interagir avec lui, soit par le biais de scripts, soit par des commandes directes. De nombreuses autres applications Docker utilisent l'API et la CLI sous-jacentes. Le démon crée et gère les objets Docker, tels que les images, les conteneurs, les réseaux et les volumes.

5. Registres Docker :

Un registre de conteneurs est un service qui permet de stocker et distribuer des images de conteneurs.

6. Docker Compose :

Docker Compose est un outil permettant d'orchestrer plusieurs applications exécutées dans des conteneurs Docker. Cela permet notamment d'écrire l'ensemble des paramètres et dépendances des applications, ainsi que la manière dont elles interagissent entre-elles dans un fichier YAML appelé docker-compose.

7. Avantages de Docker :

    Portabilité : Les conteneurs peuvent être exécutés sur n'importe quel système compatible avec Docker, ce qui facilite le déploiement dans différents environnements.
    Isolation : Chaque conteneur est isolé, ce qui améliore la sécurité et permet d'éviter les conflits de dépendances.
    Efficacité des ressources : Les conteneurs partagent le noyau du système d'exploitation, ce qui les rend plus légers en termes de mémoire et de CPU par rapport aux machines virtuelles.
    Agilité et rapidité : Les conteneurs peuvent être démarrés en quelques secondes, ce qui accélère le développement, les tests et les déploiements.


    Dockerfile command:
        
        * FROM : Permet d’indiquer à Docker sous quel OS doit tourner la machine virtuelle. C’est le premier mot clef du Dockerfile et celui ci est obligatoire.

        * RUN : Permet de lancer une commande sur votre machine virtuelle.

        * CMD : Spécifie la commande à exécuter lorsque le conteneur démarre. Cette instruction peut être remplacée par les arguments passés lors du démarrage du conteneur.

        * ENTRYPOINT : Configure un conteneur pour qu'il soit exécutable comme une application, permettant de fixer une commande qui sera toujours exécutée. CMD peut être utilisé pour fournir des arguments à ENTRYPOINT.

        * COPY : Copie des fichiers ou des répertoires du système de fichiers hôte dans le système de fichiers du conteneur.

        * EXPOSE : Indique que le conteneur écoute sur les ports réseau spécifiés au moment de l'exécution.


/*----------------------------------------------------------------------------------------------------------------------------*\

NGINX



Nginx (prononcé « engine-x ») est un serveur web open source polyvalent et performant qui joue un rôle crucial dans l'infrastructure web moderne et la gestion des conteneurs . Initialement conçu pour relever le défi de la gestion de quantités massives de connexions simultanées,

Principales fonctionnalités de Nginx

     Architecture pilotée par événements : Contrairement aux machines web traditionnelles qui créent un nouveau processus ou thread pour chaque connexion entrante, Nginx utilise une approche pilotée par les événements. Cela signifie qu'il peut gérer un nombre massif de connexions avec une utilisation minimale des ressources, ce qui le rend très efficace et évolutif.
     
    Serveur HTTP : Nginx est principalement utilisé comme serveur HTTP pour servir des pages web. Il est capable de gérer un grand nombre de connexions simultanées grâce à son architecture asynchrone et événementielle.

     Reverse Proxy : Nginx peut agir comme un proxy inverse, assis en face d'une ou plusieurs machines backend (comme Apache ou Node.js). Cela permet à Nginx de gérer le trafic entrant et le cache, d'effectuer un équilibrage de charge et de fournir des fonctionnalités de sécurité supplémentaires avant de transmettre les demandes au serveur principal approprié.

     Répartition de charge : Il peut répartir le trafic entrant sur plusieurs serveurs principaux, évitant ainsi la surcharge d’un seul serveur. Cela améliore les performances, la fiabilité et la tolérance aux pannes du site.
 
     Proxy de messagerie : Nginx peut aussi être configuré comme un proxy pour des services de messagerie tels que IMAP, POP3, et SMTP.

    Mise en cache : Pour stocker le contenu fréquemment consulté dans son cache, ce qui lui permet de traiter les demandes ultérieures pour cette page directement à partir du cache au lieu de l'extraire du serveur principal. Cela réduit considérablement la charge du serveur et améliore la vitesse du site web.

    Sécurité : Nginx offre diverses fonctionnalités de sécurité, y compris la terminaison SSL/TLS, la limitation du débit, le contrôle d'accès et la protection contre les attaques courantes.

Utilisations courantes

    Hébergement de sites web statiques et dynamiques : Grâce à sa capacité à gérer des connexions concurrentes, Nginx est souvent utilisé pour héberger des sites web à fort trafic.
    Proxy inverse : Pour protéger les serveurs backend et améliorer les performances grâce à la mise en cache et à l'équilibrage de charge.
    Équilibrage de charge : Pour distribuer le trafic sur plusieurs serveurs et améliorer la disponibilité des applications.
    Passerelle API : Pour gérer et sécuriser les appels API, en fournissant des fonctionnalités comme la limitation de débit, l'authentification et la mise en cache.

        Dockerfile :

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

        Fichier config:

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

        # Define the location of the access log
        access_log /var/log/nginx/access.log;
        # Define the location of the error log
        error_log /var/log/nginx/error.log;

        # Enable gzip compression
        gzip on;
    }

}

/*----------------------------------------------------------------------------------------------------------------------------*\

MARIADB

MariaDB est un système de gestion de bases de données relationnelle indépendant, offrant des performances élevées, des moteurs de stockage flexibles et une compatibilité parfaite avec MySQL. Il se distingue aussi par ses fonctionnalités de sécurité complètes, son support JSON et sa scalabilité simple. Les principales utilisations de MariaDB incluent les applications Web, les bases de données Cloud, le E-commerce et les applications d’entreprise.

    Compatibilité avec MySQL : MariaDB est compatible avec MySQL. Cela permet de convertir généralement les applications existantes, les outils et les scripts utilisant MySQL sans grand effort.

    Haute performance : grâce à des fonctionnalités telles que des moteurs de stockage spécialisés, MariaDB parvient à traiter rapidement les requêtes même sous une charge importante et avec de grands volumes de données. La scalabilité horizontale par la réplication et le clustering est facile à configurer.

    Communauté active : une communauté mondiale composée de développeurs et entreprises contribue à l’évolution des bases de données MariaDB. Celles-ci bénéficient continuellement de nouvelles fonctionnalités et de mises à jour régulières.

    Entièrement open source et gratuit : MariaDB est sous licence GPLv2. Cela élimine les frais de licence et vous donne un accès complet au code source, vous offrant une grande liberté pour adapter et étendre le logiciel.

Utilisations courantes de MariaDB

  Applications Web : MariaDB est souvent utilisée pour gérer des données dans des applications web. Un exemple sont les systèmes de gestion de contenu comme WordPress, Joomla! ou Drupal, qui fonctionnent de manière fiable sur MariaDB malgré un grand nombre de visiteurs.
  Bases de données Cloud : de nombreux fournisseurs Cloud comme Amazon Web Services (AWS), Google Cloud et Microsoft Azure proposent MariaDB en tant que service entièrement géré. Cela permet de faire évoluer les bases de données de manière flexible et de les maintenir automatiquement.
  Boutiques en ligne : dans les systèmes de commerce électronique comme Magento, MariaDB gère les catalogues de produits, les commandes et les données des clients. Les bases de données MariaDB garantissent des transactions rapides, même avec un grand nombre d’utilisateurs.
  Applications critiques pour l’entreprise : un autre domaine d’application concerne les environnements critiques pour l’entreprise avec des exigences élevées en matière de disponibilité et de performance.

        Dockerfile:

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


    Fichier configue:

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

# The file where MariaDB will log errors
log_error = /var/log/mysql/error.log


        Script:

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


/*----------------------------------------------------------------------------------------------------------------------------*\

WORDPRESS

WordPress est un système de gestion de contenu gratuit et open-source qui permet à toute personne de créer et de gérer facilement des sites internet. Lancé en tant que plateforme de blogs, le logiciel WordPress a évolué pour aider les utilisateurs à créer divers sites, des blogs et portfolios aux boutiques e-commerce

    Facilité d'utilisation : WordPress est réputé pour sa simplicité d'utilisation, permettant aux utilisateurs de créer et de gérer des sites web sans avoir besoin de connaissances techniques approfondies.

    Flexibilité : WordPress offre une grande flexibilité grâce à des milliers de thèmes et de plugins disponibles, pour créer n’importe quel type de site : un blog ou un site personnel, un blog photo, un site d’entreprise, un portfolio professionnel, un site gouvernemental, un magazine ou un site d’information, une communauté en ligne, voire un réseau de sites.

    Communauté : En tant que CMS open source le plus populaire sur le web, WordPress dispose d’une communauté dynamique et solidaire.

    Multilingue : WordPress est disponible dans plus de 70 langues.

    Sécurité : Bien qu'aucun système ne soit totalement à l'abri des failles de sécurité, WordPress s'efforce d'améliorer constamment sa sécurité et propose des mises à jour régulières pour protéger les sites web contre les menaces potentielles.

Utilisations courantes de WordPress

    Blogs personnels et professionnels 
    Sites web d'entreprise
    Boutiques en ligne
    Sites web communautaires


    Dockerfile:

# Use Debian bookworm as the base image
FROM debian:bookworm

# Update qnd install PHP 8.2 FPM qnd mysql
RUN apt update -y && apt install -y wget php8.2 php-fpm php-mysql


# Download and install WP-CLI (WordPress Command Line Interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install MySQL client
RUN apt update -y && apt install -y default-mysql-client mariadb-client

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


    Fichier de configue :

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

    Script :

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


/*----------------------------------------------------------------------------------------------------------------------------*\
DOCKER-COMPOSE


# Define the version of Docker Compose format
version: '3.1'

services:
  # MariaDB service configuration
  mariadb:
    image: mariadb
    container_name: mariadb
    networks:
      - inception  # Attach to the inception network
    restart: unless-stopped
    build:
      context: ./mariadb  # Build context for MariaDB service
    env_file:
      - .env  # Load environment variables from .env file
    volumes:
      - mariadb:/var/lib/mysql  # Mount volume for MariaDB data storage
    expose:
      - "3306"  # Expose port 3306 for communication
    healthcheck:
      test: mysqladmin ping --host=localhost -p${DB_PASSWORD}  # Health check command
      interval: 5s
      timeout: 1s
      retries: 20
      start_period: 5s

  # WordPress service configuration
  wordpress:
    image: wordpress
    container_name: wordpress
    networks:
      - inception  # Attach to the inception network
    depends_on:
      mariadb:  # Ensure MariaDB is running before starting WordPress
        condition: service_healthy
    restart: unless-stopped
    build:
      context: ./wordpress  # Build context for WordPress service
    env_file:
      - .env  # Load environment variables from .env file
    volumes:
      - wordpress:/var/www/html/wordpress  # Mount volume for WordPress data storage
    expose:
      - "9000"  # Expose port 9000 for PHP-FPM
       
  # Nginx service configuration
  nginx:
    image: nginx
    container_name: nginx
    networks:
      - inception  # Attach to the inception network
    depends_on:
      - wordpress  # Ensure WordPress is running before starting Nginx
    restart: unless-stopped
    build:
      context: ./nginx  # Build context for Nginx service
    env_file:
      - .env  # Load environment variables from .env file
    ports:
      - "443:443"  # Publish port 443 for HTTPS traffic
    volumes:
      - wordpress:/var/www/html/wordpress  # Mount volume for WordPress data storage
    healthcheck:
      interval: 5s
      timeout: 1s
      retries: 10
      start_period: 5s

volumes:
  # Define volumes for MariaDB and WordPress data
  mariadb:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'  # Bind mounts allow the volumes to be mounted on a host path and can be modified by processes outside of Docker.
      device: "/home/pgiroux/data/mariadb"  # Specify where to store the folder on your local machine
  wordpress:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: "/home/pgiroux/data/wordpress"  # Specify where to store the folder on your local machine

networks:
  inception:  # Create the inception network
    name: inception
    driver: bridge