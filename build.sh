#!/bin/bash

# Simple script to build and test the CI/CD container locally

set -e

echo "🔨 Building CI/CD container..."
podman build --cgroup-manager=cgroupfs -t ci-container:latest .

echo ""
echo "✅ Build completed successfully!"
echo ""

echo "🧪 Running basic tests..."

echo "  Testing basic tools..."
podman run --cgroup-manager=cgroupfs --rm ci-container:latest bash -c "
    which python3 && echo '✓ Python3 found'
    which node && echo '✓ Node.js found' 
    which git && echo '✓ Git found'
    which curl && echo '✓ Curl found'
    which jq && echo '✓ JQ found'
"

echo "  Testing Python packages..."
podman run --cgroup-manager=cgroupfs --rm ci-container:latest python3 -c "
import pytest, requests, yaml
print('✓ pytest:', pytest.__version__)
print('✓ requests:', requests.__version__)
print('✓ pyyaml: available')
"

echo "  Testing user setup..."
podman run --cgroup-manager=cgroupfs --rm ci-container:latest bash -c "
    echo 'User:' \$(whoami)
    echo 'Working directory:' \$(pwd)
    echo 'Can write to workspace:' && echo 'test' > /workspace/test.txt && rm /workspace/test.txt && echo '✓ Yes'
"

echo ""
echo "🎉 All tests passed! Container is ready to use."
echo ""
echo "To run the container interactively:"
echo "  podman run --cgroup-manager=cgroupfs -it ci-container:latest"
echo ""
echo "To run with a mounted directory:"
echo "  podman run --cgroup-manager=cgroupfs -it -v \$(pwd):/workspace ci-container:latest"