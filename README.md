# CI/CD Container

A container image for CI/CD operations with various tools pre-installed.

## Features

- Based on Debian bookworm-slim
- Includes Python, uv package manager, and Tectonic for LaTeX builds
- YAML linting with yamllint
- Various utilities for build and automation tasks

## GitHub Workflows

### Docker Image Build and Publish

This repository includes a GitHub Actions workflow that builds and publishes the Docker image using a custom Docker action. The workflow:

- Runs on pushes to the main branch that modify the Dockerfile
- Runs on tag pushes that start with 'v' (e.g., v1.0.0)
- Can be manually triggered using workflow_dispatch
- Uses a reusable Docker action to build, test, and publish images
- The release job only runs when a tag is pushed, automatically publishing to GitHub Container Registry (GHCR)

To use the workflow:

1. The workflow runs automatically when changes are made to the Dockerfile
2. You can manually trigger it from the Actions tab in GitHub
3. To publish the image to the registry, create and push a tag that starts with 'v' (e.g., `git tag v1.0.0 && git push origin v1.0.0`)
4. When a tag is pushed, the image will be tagged with the specific version (e.g., v1.0.0)

### Release Workflow

This repository also includes a manual release workflow that creates a Git tag, builds a Docker image, and creates a GitHub release. The workflow:

- Can be manually triggered using workflow_dispatch with a tag input
- Creates a Git tag based on the provided input
- Builds and publishes the Docker image with the specified tag to GitHub Container Registry (GHCR)
- Creates a GitHub release with automatically generated release notes
- Includes Docker artifacts in the release
- Adds Docker image information to the release notes, including the image URL and pull command

To use the release workflow:

1. Go to the Actions tab in GitHub and select the "Release Workflow"
2. Click "Run workflow" and enter a release tag (e.g., v1.2.3)
3. The workflow will create the Git tag, build and publish the Docker image, and create a GitHub release
4. The Docker image will be available at `ghcr.io/{repository}/ci-image:{tag}` and can be pulled with `docker pull ghcr.io/{repository}/ci-image:{tag}`
5. The GitHub release will include a section with the Docker image URL and pull command
