Services provided by the stack

    • MariaDb   : database
    • Nginx     : free web server software
    • Wordpress : content management system

Start and Stop the project

    • Start the project 
        
        make

    • Rebuild the project
    
        make fclean

    • clean the project
        
        make clean
    or
        make prune

    • start docker
        
        make start

    • stop docker

        make stop
    
    • logs
        
        make logs

Access the website and the administation panel
    
    • Acces the webiste  

        https://pgiroux.42.fr 
    
    • Acces the administration panel
        https://pgiroux.42.fr/wp-admin

Locate and manage credentials

    To locate or manage identifiers, go to the .env file.

Check that the services are running correctly

    make logs
    or
    docker logs mariadb
    docker logs wordpress
    docker logs nginx
    
