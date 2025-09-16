# CI/CD Container

A container image for CI/CD operations with various tools pre-installed.

## Features

- Based on Debian bookworm-slim
- Includes Python, uv package manager, and Tectonic for LaTeX builds
- YAML linting with yamllint
- Various utilities for build and automation tasks

## GitHub Workflows

### Docker Image Build with Podman

This repository includes a GitHub Actions workflow that builds the Docker image using Podman. The workflow:

- Runs on pushes and pull requests that modify the Dockerfile
- Runs on tag pushes that start with 'v' (e.g., v1.0.0)
- Can be manually triggered using workflow_dispatch
- Installs Podman on the GitHub runner
- Builds the image and runs a basic test
- The release job only runs when a tag is pushed, automatically pushing to GitHub Container Registry (GHCR)

To use the workflow:

1. The workflow runs automatically when changes are made to the Dockerfile
2. You can manually trigger it from the Actions tab in GitHub
3. To push the image to the registry, create and push a tag that starts with 'v' (e.g., `git tag v1.0.0 && git push origin v1.0.0`)
4. When a tag is pushed, the image will be tagged with both the specific version (e.g., v1.0.0) and 'latest'
