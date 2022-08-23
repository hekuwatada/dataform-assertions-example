# Dataform assertions for existing tables created without Dataform

This repo is to explore use of Dataform assertions to add data quality checks for existing tables.

## Tasks

- [x] Add Dockerfile to run Dataform CLI
- [x] Add devcontainer.json for VSCode
- [x] Add assertions
- [ ] Have assertions executed regularly
- [ ] Add scripts to create the SUT table

## How to run assertions locally

```
make dataform/test
```

## Apendix

### How to run Dataform CLI locally (Docker)
```
make docker/build

# To enter a container with dataform CLI
make docker/run

# Run dataform --version in the container
# The current directry is mounted as /workspaces
```

### How to run Dataform CLI locally (VSCode)

1. Open the project in Container
2. Open Terminal to entre the container
3. Run `dataform --version`

### How this Dataform project was created

1. Set BQ_GCP_PROJECT_ID environment variable to your GCP project ID
2. Run `dataform init dataform` in the container
```
make dev/create-project
```

### References
- https://docs.dataform.co/guides/assertions