#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

if [ ! -d "$DATADIR/mysql" ]; then
  mysql_install_db --user=mysql --datadir="$DATADIR" > /dev/null
fi

mysqld --user=mysql --datadir="$DATADIR" --skip-networking & pid=$!

for i in $(seq 1 60); do
  if mysqladmin ping --silent; then break; fi
  sleep 1
done

if ! mysqladmin ping --silent; then
  echo "MariaDB ne démarre pas."
  exit 1
fi

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" || true
mysql -uroot -p"${DB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -uroot -p"${DB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -uroot -p"${DB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%'; FLUSH PRIVILEGES;"

mysqladmin -uroot -p"${DB_ROOT_PASSWORD}" shutdown

exec mysqld --user=mysql --datadir="$DATADIR" --bind-address=0.0.0.0
