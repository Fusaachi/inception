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

        # Install NGINX, vim, curl, and SSL
FROM debian:bookworm

# Update the package list
RUN apt  update -y

# Install NGINX
RUN apt install -y nginx

# Install vim
RUN apt install -y vim

# Install curl
RUN apt install -y curl

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Install openssl
RUN apt-get install -y openssl

# Generate SSL certificate and key
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pgiroux.42.fr/UID=pgiroux"

# Create directory for NGINX run files
RUN mkdir -p /var/run/nginx

# Copy the NGINX configuration file to the container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Set permissions for the web root directory
RUN chmod 755 /var/www/html

# Change ownership of the web root directory to www-data
RUN chown -R www-data:www-data /var/www/html

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
    # Enable accepting multiple new connections at once (uncomment to activate)
    # multi_accept on;
}

# Define HTTP server settings
http {

    # Define the server block for handling HTTPS traffic
    server {
        # Listen on port 443 for both IPv4 and IPv6, with SSL enabled
        listen 443 ssl;
        listen [::]:443 ssl;

        # Set the root directory for the web server
        root /var/www/html/wordpress;
        # Define the server's hostname
        server_name sdanel.42.fr;
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
            # Split the path information for PHP files
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            # Define the script filename parameter for FastCGI
            fastcgi_param SCRIPT_FILENAME $request_filename;
            # Include the FastCGI parameters
            include fastcgi_params;
            # Define the address and port of the FastCGI server
            fastcgi_pass wordpress:9000;
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

/////////////////////////////////////////////////////////////////////////////////

MARIADB

MariaDB est un système de gestion de base de données relationnelle open source, dérivé de MySQL. Il a été développé par les créateurs originaux de MySQL à la suite de l'acquisition de MySQL par Oracle Corporation. MariaDB est conçu pour être hautement compatible avec MySQL, permettant aux utilisateurs de migrer facilement entre les deux systèmes sans modifications majeures de leurs applications ou bases de données.
Principales caractéristiques de MariaDB

    Compatibilité avec MySQL : MariaDB est compatible avec MySQL, ce qui signifie que les outils, les applications et les commandes qui fonctionnent avec MySQL fonctionnent généralement aussi avec MariaDB.

    Performances améliorées : MariaDB offre des améliorations de performance par rapport à MySQL dans certains cas, grâce à l'optimisation des requêtes, des moteurs de stockage améliorés et des fonctionnalités de cache.

    Sécurité renforcée : MariaDB comprend des fonctionnalités de sécurité supplémentaires, comme des rôles d'utilisateur plus flexibles et des plugins d'authentification renforcée.

    Nouveaux moteurs de stockage : En plus des moteurs de stockage existants comme InnoDB et MyISAM, MariaDB propose de nouveaux moteurs de stockage tels que Aria, ColumnStore et MyRocks, chacun étant conçu pour des cas d'utilisation spécifiques.

    Fonctionnalités avancées : MariaDB inclut des fonctionnalités avancées comme des répliques maîtres-maîtres asynchrones, des tables virtuelles, et des vues matérialisées.

    Community-driven : En tant que projet open source, MariaDB est développé et maintenu par une communauté active de développeurs, garantissant une évolution continue et une réponse rapide aux besoins des utilisateurs.

Utilisations courantes de MariaDB

    Applications web : Utilisé comme base de données backend pour des applications web, y compris des systèmes de gestion de contenu (CMS) comme WordPress, Joomla et Drupal.
    Analytique et reporting : Utilisé pour stocker et interroger de grandes quantités de données pour des applications d'analyse et de reporting.
    Applications d'entreprise : Utilisé dans des applications d'entreprise nécessitant une base de données robuste et évolutive, comme des systèmes de gestion d'entrepôt, de gestion de la relation client (CRM), et de planification des ressources d'entreprise (ERP).


        Dockerfile:

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Install MariaDB and other dependencies
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client
RUN apt-get install -y procps

# Copy the MariaDB configuration file to the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create directories for MariaDB runtime files and data
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql

# Set ownership and permissions for the MariaDB directories
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

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

    #!/bin/bash

# Start the MariaDB service
service mariadb start;

# Log into MariaDB as root and create the database and the user
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Shut down the MariaDB service gracefully
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
# If needed for safety, restart the server upon errors and log information
# mysqladmin -u root shutdown

# Start the MariaDB server safely, allowing recovery and logging
exec mysqld_safe

# Print status message
echo "MariaDB database and user were created successfully!"



/////////////////////////////////////////////////////////////////////////////////

WORDPRESS

WordPress est un système de gestion de contenu (CMS) open source largement utilisé pour la création de sites web et de blogs. Lancé pour la première fois en 2003, WordPress est devenu l'une des plateformes les plus populaires pour la création de sites web, alimentant plus d'un tiers de tous les sites web actifs sur Internet.
Caractéristiques principales de WordPress

    Facilité d'utilisation : WordPress est réputé pour sa simplicité d'utilisation, permettant aux utilisateurs de créer et de gérer des sites web sans avoir besoin de connaissances techniques approfondies.

    Personnalisable : WordPress offre une grande flexibilité grâce à des milliers de thèmes et de plugins disponibles, permettant aux utilisateurs de personnaliser facilement l'apparence et les fonctionnalités de leur site web.

    Grande communauté : WordPress bénéficie d'une vaste communauté de développeurs, de concepteurs et d'utilisateurs qui contribuent à son développement continu, offrant un support, des conseils et des ressources utiles.

    SEO convivial : WordPress est conçu avec le référencement (SEO) à l'esprit, offrant des fonctionnalités intégrées pour améliorer la visibilité des sites web dans les moteurs de recherche.

    Multilingue : WordPress prend en charge plusieurs langues, permettant aux utilisateurs de créer des sites web multilingues.

    Sécurité : Bien qu'aucun système ne soit totalement à l'abri des failles de sécurité, WordPress s'efforce d'améliorer constamment sa sécurité et propose des mises à jour régulières pour protéger les sites web contre les menaces potentielles.

Utilisations courantes de WordPress

    Blogs personnels et professionnels : WordPress a été initialement conçu comme une plateforme de blogging et reste populaire pour la création de blogs personnels, professionnels et d'entreprise.

    Sites web d'entreprise : De nombreux sites web d'entreprise utilisent WordPress pour créer des sites web institutionnels, vitrines, portfolios et autres.

    Boutiques en ligne : Avec l'aide de plugins comme WooCommerce, WordPress est également utilisé pour créer des boutiques en ligne et des sites de commerce électronique.

    Sites web communautaires : WordPress peut être utilisé pour créer des forums, des réseaux sociaux et d'autres types de sites web communautaires grâce à des plugins comme BuddyPress.


    Dockerfile:

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Update package list
RUN apt-get update -y

# Upgrade installed packages
RUN apt-get upgrade -y

# Install wget to download files
RUN apt-get install -y wget

# Install PHP-FPM 7.4 and MySQL module
RUN apt-get install -y php7.4 php-fpm php-mysql

# Download and install WP-CLI (WordPress Command Line Interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install MySQL client
RUN apt-get update && apt-get install -y default-mysql-client
RUN apt-get install -y mariadb-client

# Download WordPress archive and extract it to /var/www/html directory
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html \
    && cd /var/www/html \
    && tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
    && rm /var/www/html/wordpress-6.1.1.tar.gz

# Set permissions for web server to read and execute files in the web root directory
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

# Expose PHP-FPM port 9000
EXPOSE 9000

# Copy script for WordPress setup
COPY ./conf/wpscript.sh .
RUN chmod +x ./wpscript.sh

# Copy custom PHP-FPM configuration file
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

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

# Change directory to WordPress installation directory
cd /var/www/html/wordpress

# Check if wp-config.php file exists
if [ ! -f wp-config.php ]; then
    # If wp-config.php does not exist, create it
    echo "Creating config ...\n"
    # Use WP-CLI to create wp-config.php with specified database credentials
    wp config create --allow-root \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --dbhost=mariadb \
        --path='/var/www/html/wordpress' \
        --url=https://${DOMAIN_NAME}

    # Use WP-CLI to install WordPress with specified settings
    wp core install --allow-root \
        --path='/var/www/html/wordpress' \
        --url=https://${DOMAIN_NAME} \
        --title=${SITE_TITLE} \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWORD} \
        --admin_email=${ADMIN_EMAIL}

    # Use WP-CLI to create additional user with specified role and credentials
    wp user create --allow-root \
        ${USER1_LOGIN} ${USER1_MAIL} \
        --role=author \
        --user_pass=${USER1_PASS}

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


/////////////////////////////////////////////////////////////////////////////////

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
      - "3306:3306"  # Expose port 3306 for communication
    healthcheck:
      test: mysqladmin ping --host=localhost -p${SQL_ROOT_PASSWORD}  # Health check command
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
      - "9000:9000"  # Expose port 9000 for PHP-FPM
       
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
      device: "/home/nsalhi/data/mariadb"  # Specify where to store the folder on your local machine
  wordpress:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: "/home/nsalhi/data/wordpress"  # Specify where to store the folder on your local machine

networks:
  inception:  # Create the inception network
    name: inception
    driver: bridge

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- docker ps

- docker exec -it mariadb-container /bin/bash

- mysql -u root -p

- SHOW DATABASES;

- USE wordpress;

- EXIT;
