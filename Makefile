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

.PHONY: docker/dataform
docker/dataform:
	@echo "\n== docker/dataform\n"
	docker run -it --rm --mount src="$$(pwd)",target=/workspaces,type=bind -w /workspaces $(DOCKER_IMAGE_TAG) $(ARGS)

##############################
# Dev utilities
##############################
# create the project structure
# TODO: make target fail when BQ_GCP_PROJECT_ID env variable is not set
.PHONY: dev/create-project
dev/create-project:
	@echo "\n== BQ_GCP_PROJECT_ID=<your GCP project ID> dev/create-project\n"
	$(MAKE) docker/dataform ARGS="init bigquery --default-database ${BQ_GCP_PROJECT_ID} --default-location EU --include-schedules true --include-environments true"
	touch definitions/.gitkeep
	touch includes/.gitkeep

.PHONY: dev/delete-project
dev/delete-project:
	@echo $@
	@echo "\n== dev/delete-project\n"
	rm -rf definitions
	rm -rf includes
	rm -f dataform.json
	rm -f environments.json
	rm -f package*.json
	rm -f schedules.json