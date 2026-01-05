all:
	sudo mkdir -p /home/pgiroux/data/mariadb
	sudo mkdir -p /home/pgiroux/data/wordpress
	sudo docker compose -f srcs/docker-compose.yml up -d --build

debug:
	sudo docker compose -f srcs/docker-compose.yml up --build --watch

start:
	sudo docker compose -f srcs/docker-compose.yml start

logs:
	sudo docker compose -f srcs/docker-compose.yml logs

stop:
	sudo docker compose -f srcs/docker-compose.yml stop

clean:
	sudo docker compose -f srcs/docker-compose.yml down --rmi all --volumes

fclean: clean

re:
	sudo docker compose -f srcs/docker-compose.yml up -d --force-recreate --build

prune: fclean
	sudo docker container prune -f
	sudo docker image prune -a -f
	sudo docker volume prune -a -f
	sudo docker system prune -a -f