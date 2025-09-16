# CI/CD Container

A lightweight CI/CD container image based on Ubuntu 22.04 with essential tools for continuous integration and continuous deployment workflows.

## Features

- **Base**: Ubuntu 22.04 LTS
- **Languages**: Python 3.10, Node.js 12.x
- **Tools**: Git, curl, wget, jq, build-essential
- **Python Packages**: pytest, requests, pyyaml
- **Security**: Runs as non-root user (`ciuser`)
- **Container Runtime**: Optimized for Podman

## Quick Start

### Building the Container

```bash
# Clone the repository
git clone https://github.com/tschm/ci.git
cd ci

# Build using the provided script
./build.sh

# Or build manually with Podman
podman build --cgroup-manager=cgroupfs -t ci-container:latest .
```

### Running the Container

```bash
# Interactive shell
podman run --cgroup-manager=cgroupfs -it ci-container:latest

# With mounted directory
podman run --cgroup-manager=cgroupfs -it -v $(pwd):/workspace ci-container:latest

# Run a command
podman run --cgroup-manager=cgroupfs --rm ci-container:latest python3 --version
```

## CI/CD Workflows

This repository includes GitHub Actions workflows for:

- **Build**: Builds and tests the container on every push/PR
- **Test**: Comprehensive testing of container functionality
- **Release**: Builds and publishes container images to GitHub Container Registry

### Triggering a Release

Create a new tag to trigger a release:

```bash
git tag v1.0.0
git push origin v1.0.0
```

### Using Published Images

```bash
# Pull from GitHub Container Registry
podman pull ghcr.io/tschm/ci:latest

# Run the published image
podman run --cgroup-manager=cgroupfs -it ghcr.io/tschm/ci:latest
```

## Container Contents

### System Tools
- curl, wget, git, jq
- build-essential (gcc, g++, make)
- tree, vim, nano, ssh, rsync
- zip/unzip utilities

### Development Environment
- Python 3.10 with pip
- Node.js with npm
- Essential Python packages for testing and development

### Security Features
- Non-root user (`ciuser`) with UID/GID 1000
- Minimal attack surface
- No unnecessary services running

## Development

### Project Structure
```
.
├── Dockerfile              # Container definition
├── .dockerignore           # Files excluded from build context
├── build.sh               # Local build and test script
├── .github/workflows/     # CI/CD workflows
│   ├── build.yml         # Build and basic testing
│   ├── test.yml          # Comprehensive testing
│   └── release.yml       # Release and publishing
└── README.md             # This file
```

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally with `./build.sh`
5. Submit a pull request

### Testing Locally

The `build.sh` script performs comprehensive testing:
- Builds the container
- Tests all included tools
- Verifies Python packages
- Checks security (non-root user)
- Validates workspace permissions

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Author

Thomas Schmelzer
