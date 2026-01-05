#!/bin/bash

sleep 10

cd /var/www/html/wordpress

if [ ! -f wp-config.php ]; then
	echo "CREATING CONFIG .... !\n"
	wp config create --allow-root \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_PASSWORD} \
		--dbhost=mariadb \
		--path='/var/www/html/wordpress' \
		--url=https://${WP_URL}

	wp core install	--allow-root \
				--path='/var/www/html/wordpress' \
				--url=https://${WP_URL} \
				--title=${WP_TITLE} \
				--admin_user="${WP_ADMIN}" \
				--admin_password="${WP_ADMIN_PASSWORD}" \
				--admin_email="${WP_ADMIN_EMAIL}"

	wp user create \
				"${WP_USER}" "${WP_USER_EMAIL}" \
				--role=author \
				--user_pass="${WP_USER_PASSWORD}" --allow-root

	wp cache flush --allow-root
	echo "wp-config created successfully !"
fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

exec /usr/sbin/php-fpm8.2 -F -R


