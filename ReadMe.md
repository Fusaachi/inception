
/*This project has been created as part of the 42 curriculum by pgiroux

Description

This project aims to expand knowledge of system administration using Docker.
By virtualizing multiple Docker images by creating them in a personal virtual machineThis project aims to expand knowledge of system administration using Docker.

This project consists of having you set up a small infrastructure composed of different
services under specific rules. The whole project has to be done in a virtual machine using Docker Compose

Each Docker image must have the same name as the corresponding service.
Each service must be run in a dedicated container.
For performance reasons, containers are built from the penultimate stable version
of Debian.
Each Dockerfile must be written by yourself, one per service. Dockerfiles must
be called in the docker-compose.yml file by the Makefile.
It is  prohibited to use ready-made Docker images, as well as services such as DockerHub
(Alpine/Debian being excluded from this rule), so the project's Docker images are created by yourself.
The configuration:
• A Docker container containing NGINX with TLSv0.2 or TLSv1.3 only.
• A Docker container containing only WordPress + php-fpm (which must be installed and
configured), without nginx.
• A Docker container containing only MariaDB, without nginx.
• A volume containing your WordPress database.
• A second volume containing your WordPress website files.
• Volumes named Docker are used for two persistent storages. Linked mounts
are not allowed for these volumes.
• Both named volumes must store their data in /home/login/data on the host machine.
• A Docker network that establishes the connection between containers.
Containers must restart in case of failure.

Instruction 

    1) Open Oracle VM Virtualbox

    2) Start the VM 

    3) Into the VM : 

        1) Clone repository :

            git clone git@vogsphere.42paris.fr:vogsphere/intra-uuid-c0a3721c-700f-4f90-800a-fb2c8b33919e-7020638-pgiroux inception
            cd inception

        2) Create a .env file in the srcs repository :

            vim ./inception/srcs/.env

                    EXEMPLE

            DB_NAME = mariadb
            DB_USER = userdb
            DB_PASSWORD = passworddb

            WP_URL = login.42.fr
            WP_TITLE =  title
            WP_ADMIN =  admin
            WP_ADMIN_PASSWORD =  passwordadmin 
            WP_ADMIN_EMAIL =  admin@email.com

            WP_USER = wpuser
            WP_USER_PASSWORD = passwordwp  
            WP_USER_EMAIL = wpuser@email.com

        3) Launch

            make

        4) In the Bowser
        
            open https://login.42.fr

        5) Verif DataBase

            • Docker exec -it mariadb bash
            • mysql -u root -p
            • SHOW Databases;
            • USE wordpress;
            • SHOW TABLES;
        6) Clean 
        
            make prune


Resources

https://tuto.grademe.fr/inception/
https://www.nicelydev.com/docker
https://docs.docker.com/compose/
https://www.debian.org/download.fr.html
https://fr.wikipedia.org/wiki/NGINX
https://fr.wikipedia.org/wiki/MariaDB
https://fr.wikipedia.org/wiki/WordPre

Project description


• DOCKER
Docker is both a software library and platform that allows certain applications to run in containers. Docker allows you to package an application and its dependencies in an isolated container that can be run on any server.

• NGINX
Nginx (pronounced “engine-x”) is a versatile and high-performance open source web server that plays a crucial role in modern web infrastructure and container management. Initially designed to address the challenge of managing massive amounts of simultaneous connections.

• MARIADB
MariaDB is an independent relational database management system offering high performance, flexible storage engines, and perfect compatibility with MySQL. It also stands out for its comprehensive security features, JSON support, and easy scalability. The main uses of MariaDB include web applications, cloud databases, e-commerce, and enterprise applications.

• WORDPRESS
WordPress is a free and open-source content management system that allows anyone to easily create and manage websites. Launched as a blogging platform, WordPress software has evolved to help users create a variety of sites, from blogs and portfolios to e-commerce stores.

• Virtual Machines vs Docker
A VM allows you to run a virtual machine on any hardware. Docker allows you to run an application on any operating system
• Secrets vs Environment Variables
The difference between the two is that environment variables have values that can be revealed, while secrets have hidden values. 

• Docker Network vs Host NetworkThe Docker Network provides network isolation for containers with private IP addresses, while the Host Network allows containers to directly use the host's network interface, without isolation.

• Docker Volumes vs Bind Mounts
Bind mounts directly link a file or directory on the host to a container, while volumes are storage spaces managed by Docker, which are more secure and portable.
