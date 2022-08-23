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

## References
- https://docs.dataform.co/guides/assertions
