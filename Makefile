# Big thanks to https://github.com/internavenue/docker-centos-nginx
DOCKER_USER=rotespferd
DOCKER_REPO_NAME=centos-nginx-hhvm

# Change this to suit your needs.
CONTAINER_NAME:=nginx-hhvm
DATA_DIR:=/home/core/share/source/test/www
CONF_DIR:=/home/core/share/source/test/conf
PORT:=80

RUNNING:=$(shell docker ps | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
DOCKER_RUN_COMMON=--name="$(CONTAINER_NAME)" -p $(PORT):80 -v $(DATA_DIR):/var/www -v $(CONF_DIR):/etc/nginx/conf.d $(DOCKER_USER)/$(DOCKER_REPO_NAME)

all: build

build:
	docker build -t="$(DOCKER_USER)/$(DOCKER_REPO_NAME)" .

run: clean
	# mkdir -p $(DATA_DIR)
	docker run -d $(DOCKER_RUN_COMMON)

bash: clean
	# mkdir -p $(DATA_DIR)
	docker run -t -i $(DOCKER_RUN_COMMON) /bin/bash

# Removes existing containers.
clean:
ifneq ($(strip $(RUNNING)),)
	docker stop $(RUNNING)
endif
ifneq ($(strip $(ALL)),)
	docker rm $(ALL)
endif

# Destroys the data directory.
deepclean: clean
	sudo rm -rf $(DATA_DIR)
