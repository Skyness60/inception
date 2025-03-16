# Nom du projet
NAME = inception

# Nom du fichier docker-compose
COMPOSE_FILE = ./srcs/docker-compose.yml


# Codes de couleur ANSI
BOLD=$(shell echo -e "\033[1m")
RESET=$(shell echo -e "\033[0m")
GREEN=$(shell echo -e "\033[32m")
YELLOW=$(shell echo -e "\033[33m")
RED=$(shell echo -e "\033[31m")

# Réseau Docker
NETWORK_NAME = inception

# Dossier des volumes
VOLUMES_PATH = /home/$(USER)/data

# Commandes
DOCKER_COMPOSE = docker-compose
MKDIR = mkdir -p
RM = rm -rf
TOUCH = touch

# Fichier témoin pour éviter le relink
UP_FLAG = .make_up

# Liste des services définis dans docker-compose
SERVICES = $(shell $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) config --services)

# Règles principales
all: up

up: $(UP_FLAG)

$(UP_FLAG):
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d --build
	$(TOUCH) $(UP_FLAG)

down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down
	$(RM) $(UP_FLAG)

restart: down up

clean: down
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) rm -f
	$(RM) $(VOLUMES_PATH)

prune: clean
	docker system prune -af --volumes

logs:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

ps:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

exec:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) exec $(SERVICE) sh

re: down up


evaluation:
	$(RM) $(UP_FLAG)
	@if [ -n "$$(docker ps -qa)" ]; then \
		echo "$(BOLD)$(YELLOW)Stopping containers...$(RESET)"; \
		docker stop $$(docker ps -qa) > /dev/null || true; \
	fi
	@if [ -n "$$(docker ps -qa)" ]; then \
		echo "$(BOLD)$(YELLOW)Removing containers...$(RESET)"; \
		docker rm $$(docker ps -qa) > /dev/null || true; \
	fi
	@if [ -n "$$(docker images -qa)" ]; then \
		echo "$(BOLD)$(YELLOW)Removing images...$(RESET)"; \
		docker rmi -f $$(docker images -qa) > /dev/null || true; \
	fi
	@if [ -n "$$(docker volume ls -q)" ]; then \
		echo "$(BOLD)$(YELLOW)Removing volumes...$(RESET)"; \
		docker volume rm $$(docker volume ls -q) > /dev/null || true; \
	fi
	@if [ -n "$$(docker network ls -q)" ]; then \
		echo "$(BOLD)$(YELLOW)Removing networks...$(RESET)"; \
		docker network rm $$(docker network ls -q) > /dev/null || true; \
	fi

.PHONY: all up down restart clean prune logs ps exec re evaluation
