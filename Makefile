#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

# [ -f (pwd)/.env ] && include .env || include .env.example;
include .env
export

SHELL = /bin/sh

BACKUP_NAME := db
CURRENT_TIME := $(shell date --iso=seconds)

docker_bin := $(shell command -v docker 2> /dev/null)
docker_compose_bin := $(shell command -v docker-compose 2> /dev/null)

.DEFAULT_GOAL := help

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "\n  Allowed for overriding next properties:\n\n\
		Usage example:\n\
	    	make up"

# --- [ Docker ] -------------------------------------------------------------------------------------------------

build: ## rebuild all containers
	$(docker_compose_bin) build

up: build ## rebuild and up all containers
	$(docker_compose_bin) up -d --remove-orphans

down: ## down all containers
	$(docker_compose_bin) down

restart: build down up ## rebuild and restart all containers

stop: ## stop all containers
	@$(docker_bin) ps -aq | xargs $(docker_bin) stop

