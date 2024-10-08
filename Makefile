# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/12 10:15:37 by ncasteln          #+#    #+#              #
#    Updated: 2024/10/08 13:53:52 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Project and services
NAME := inception
SERVICES := nginx #mariadb wordpress
DOCKER_COMPOSE := ./srcs/docker-compose.yml
NGINX_BUILD_PATH := ./srcs/requirements/nginx
MARIADB_BUILD_PATH := ./srcs/requirements/mariadb
WORDPRESS_BUILD_PATH := ./srcs/requirements/wordpress

# Default target: Build and start the project
all: $(NAME)

# Build and run all services
$(NAME): $(SERVICES)
	@echo "$(ORG)----- Starting $(NAME) services -----$(RESET)"
	@sudo docker-compose -f $(DOCKER_COMPOSE) up -d
	@echo "$(ORG)----- $(NAME) is running with MariaDB, Nginx, and WordPress! -----$(RESET)"

# Build each service
nginx:
	@echo "$(ORG)----- Building Nginx Service -----$(RESET)"
	@sudo docker build -t nginx $(NGINX_BUILD_PATH)

mariadb:
	@echo "$(ORG)----- Building MariaDB Service -----$(RESET)"
	@sudo docker build -t mariadb $(MARIADB_BUILD_PATH)

wordpress:
	@echo "$(ORG)----- Building WordPress Service -----$(RESET)"
	@sudo docker build -t wordpress $(WORDPRESS_BUILD_PATH)

# Clean stopped containers and images
clean:
	@echo "Cleaning stopped containers..."
	@sudo docker container prune -f
	@echo "Cleaning unused images..."
	@sudo docker image prune -f

# Full clean: remove all containers, networks, volumes, images
fclean: clean
	@echo "Stopping and removing containers..."
	@sudo docker-compose -f $(DOCKER_COMPOSE) down
	@echo "Removing all images..."
	@sudo docker rmi -f $(shell sudo docker images -q)

# Rebuild everything
re: fclean all

# Report container status
report:
	@sudo docker ps -a

# Declare phony targets
.PHONY: all clean fclean re report nginx mariadb wordpress


BLUE    = \033[38;5;4m
GREEN   = \033[38;5;2m
ORG     = \033[38;5;214m
RED     = \033[38;5;196m
RESET   = \033[0m
