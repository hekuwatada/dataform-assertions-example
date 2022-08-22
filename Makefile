.ONESHELL:
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -euc

DOCKER_IMAGE_TAG = 'dataform-local'

##############################
# Docker
##############################
# build Docker image
.PHONY: docker/build
docker/build:
	@echo "\n== docker/build\n"
	docker build -t $(DOCKER_IMAGE_TAG) .

# run Docker image mounting the current directory
.PHONY: docker/run
docker/run:
	@echo "\n== docker/run\n"
	docker run -it --rm --mount src="$$(pwd)",target=/workspaces,type=bind --entrypoint /bin/bash $(DOCKER_IMAGE_TAG) 
