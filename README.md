# Dataform assertions for existing tables created without Dataform

This repo is to explore use of Dataform assertions to add data quality checks for existing tables.

## Tasks
- [ ] Add Dockerfile to run Dataform CLI
- [ ] Add assertions
- [ ] Have assertions executed regularly

## How to run Dataform CLI locally (Docker)
```
make docker/build

# To enter a container with dataform CLI
make docker/run

# Run dataform --version in the container
# The current directry is mounted as /workspaces
```

## How to run Dataform CLI locally (VSCode)
1. Open the project in Container
2. Open Terminal to entre the container
3. Run `dataform --version`

## Apendix

### How this Dataform project was created
1. Set BQ_GCP_PROJECT_ID environment variable to your GCP project ID
2. Run `dataform init` in the container
```
make dev/create-project
```

### References
- https://docs.dataform.co/guides/assertions