# Nom du projet
NAME = inception

# Nom du fichier docker-compose
COMPOSE_FILE = ./srcs/docker-compose.yml

# Réseau Docker
NETWORK_NAME = inception_network

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

re: prune all


.PHONY: all up down restart clean prune logs ps exec re 
