FROM debian:bookworm

RUN apt update -y && apt install -y wget php8.2 php-fpm php-mysql
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN apt update -y && apt install -y default-mysql-client mariadb-client && wget https://wordpress.org/wordpress-6.8.tar.gz -P /var/www/html
RUN cd /var/www/html && tar -xzf /var/www/html/wordpress-6.8.tar.gz && rm /var/www/html/wordpress-6.8.tar.gz
RUN chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/* 

EXPOSE 9000
COPY ./conf/wpscript.sh .
RUN chmod +x ./wpscript.sh
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "./wpscript.sh"]