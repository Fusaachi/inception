FROM debian:bookworm

RUN apt update -y && apt install -y mariadb-server mariadb-client procps

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld  /var/lib/mysql && chown -R mysql:mysql /var/run/mysqld/ /var/lib/mysql/ && chmod -R 755 /var/run/mysqld/ /var/lib/mysql/

EXPOSE 3306

COPY ./conf/init.sh .
RUN chmod +x ./init.sh

ENTRYPOINT ["bash", "./init.sh"]