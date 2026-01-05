# Install NGINX, vim, curl et ssl
FROM debian:bookworm

RUN apt update -y && apt install nginx vim curl -y && mkdir -p /etc/nginx/ssl && apt install openssl -y

#Create SSL keys & certificates
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pgiroux.42.fr/UID=pgiroux"

#Copy files .conf
RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

#Principal root && principal user
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]