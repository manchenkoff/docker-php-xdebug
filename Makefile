.DEFAULT_GOAL := help
.PHONY: help clean build run

DOCKER_IMAGE_NAME = "manchenkoff/php-xdebug"
DOCKER_COMPOSE_CMD := docker-compose -f docker.yml

help: ## Show this message
	@echo "Application management"
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

publish: ## Publish new image version
	@docker image push ${DOCKER_IMAGE_NAME}

build: ## Build docker image
	@docker build src/

up: ## Run container
	@$(DOCKER_COMPOSE_CMD) up -d --build

down: ## Stop container
	@$(DOCKER_COMPOSE_CMD) down

reload: ## Reload running container
	@$(DOCKER_COMPOSE_CMD) up -d

start: ## Stop docker-compose
	@$(DOCKER_COMPOSE_CMD) start

stop: ## Stop docker-compose
	@$(DOCKER_COMPOSE_CMD) stop
