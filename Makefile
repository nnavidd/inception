# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/12 10:15:37 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/23 23:28:47 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Project and services
NAME := inception
DOCKER_COMPOSE_ADD := ./srcs/docker-compose.yml

# Default target: Build and start the project
all: $(NAME)

# Build and run all services
$(NAME):
	@echo "$(ORG)----- $(NAME) is building MariaDB, Nginx, and WordPress containers! -----$(RESET)"
#@docker compose -f $(DOCKER_COMPOSE_ADD) build --no-cache
	@docker compose -f $(DOCKER_COMPOSE_ADD) build
	@echo "$(ORG)----- $(NAME) is running with MariaDB, Nginx, and WordPress! -----$(RESET)"
	@docker compose -f $(DOCKER_COMPOSE_ADD) up -d
stop:
	@echo "$(ORG)----- Stoping $(NAME) services -----$(RESET)"
	@docker compose -f $(DOCKER_COMPOSE_ADD) down

restart:
	@echo "$(ORG)----- Stoping $(NAME) services -----$(RESET)"
	@docker compose -f $(DOCKER_COMPOSE_ADD) restart

# Clean stopped containers and images
clean:
	@echo "$(ORG)----- Cleaning stopped containers... -----$(RESET)"
	@docker compose -f $(DOCKER_COMPOSE_ADD) rm 
	
	@echo "$(ORG)----- Cleaning unused images... -----$(RESET)"	# @docker image prune -f
	@docker container prune -f

# Full clean: remove all containers, networks, volumes, images
fclean: clean
	@echo "$(ORG)----- Stopping and removing containers... -----$(RESET)"
	@docker compose -f $(DOCKER_COMPOSE_ADD) down
	@echo "$(ORG)----- Removing all images... -----$(RESET)"
	@docker rmi $(shell docker compose -f $(DOCKER_COMPOSE_ADD) images -q)

# Rebuild everything
re: fclean all

# Report container status
report:
	@docker compose -f $(DOCKER_COMPOSE_ADD) logs

# Declare phony targets
.PHONY: all clean fclean re report nginx mariadb wordpress


BLUE    = \033[38;5;4m
GREEN   = \033[38;5;2m
ORG     = \033[38;5;214m
RED     = \033[38;5;196m
RESET   = \033[0m
