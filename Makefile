
NAME ?= the-widget
WIDGET_DIR ?= /blah

#
# Defines a default make target so that help is printed if make is called
# without a target
#
.DEFAULT_GOAL := help

.PHONY: help up down

up:  ## docker-compose up
	NAME=$(NAME) WIDGET_DIR=$(WIDGET_DIR) docker-compose up -d
	sleep 3
	docker logs the-widget

logs:  ## Show the container logs
	docker logs $(NAME)

down:  ## docker-compose down
	docker-compose down

help:  ## show this help.
	@echo "make targets:"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ": .*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""; echo "make vars (+defaults):"
	@grep -E '^[0-9a-zA-Z_-]+ \?=.*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = " \\?\\= "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
