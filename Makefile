.ONESHELL:
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -euc

DOCKER_IMAGE_TAG = 'dataform-local'
DATAFORM_DIR = 'dataform'

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
	docker run -it --rm --mount src="$$(pwd)",target=/workspaces,type=bind -w /workspaces/$(DATAFORM_DIR) $(DOCKER_IMAGE_TAG) $(ARGS)

##############################
# Dev utilities
##############################
# create the project structure
# TODO: make target fail when BQ_GCP_PROJECT_ID env variable is not set
.PHONY: dev/create-project
dev/create-project:
	@echo "\n== BQ_GCP_PROJECT_ID=<your GCP project ID> dev/create-project\n"
	$(MAKE) docker/dataform ARGS="init bigquery --default-database ${BQ_GCP_PROJECT_ID} --default-location EU --include-schedules true --include-environments true"
	touch $(DATAFORM_DIR)/definitions/.gitkeep
	touch $(DATAFORM_DIR)/includes/.gitkeep

.PHONY: dev/delete-project
dev/delete-project:
	@echo $@
	@echo "\n== dev/delete-project\n"
	rm -rf $(DATAFORM_DIR)/definitions
	rm -rf $(DATAFORM_DIR)/includes
	rm -f $(DATAFORM_DIR)/dataform.json
	rm -f $(DATAFORM_DIR)/environments.json
	rm -f $(DATAFORM_DIR)/package*.json
	rm -f $(DATAFORM_DIR)/schedules.json