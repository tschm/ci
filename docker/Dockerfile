# CI/CD Container Image
# Base image with common CI/CD tools
FROM python:3.14-slim-bookworm

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install basic CI/CD tools
RUN apt-get update && apt-get install -y \
    # Basic utilities \
    curl \
    wget \
    git \
    unzip \
    zip \
    jq \
    # Build tools \
    # build-essential \
    # Node.js and npm \
    nodejs \
    npm \
    # Additional useful tools \
    tree \
    # vim \
    nano \
    ssh \
    rsync \
    ca-certificates

# Install common Python packages for CI/CD
# Using trusted hosts to handle SSL issues in some environments
RUN pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org \
    pytest \
    requests \
    pyyaml \
    pre-commit || \
    echo "Warning: Some Python packages may not have been installed due to network issues"

# Install uv and uvx from astral-sh image
COPY --from=ghcr.io/astral-sh/uv:0.8.19 /uv /uvx /usr/local/bin/

# Verify installation
RUN uv --version && uvx --version

# Create a non-root user for security
RUN useradd -m -s /bin/bash ciuser

# Set working directory
WORKDIR /workspace

# Change ownership of workspace to ciuser and ensure access to /usr/local/bin
RUN chown ciuser:ciuser /workspace && \
    chmod -R 755 /usr/local/bin && \
    chown -R root:root /usr/local/bin

# Switch to non-root user
USER ciuser

# Add /usr/local/bin to PATH
ENV PATH="/usr/local/bin:${PATH}"

# Default command
CMD ["/bin/bash"]

# Build arguments for version
ARG VERSION="dev"

# Labels for metadata
LABEL maintainer="Thomas Schmelzer"
LABEL description="CI/CD container with common tools and utilities"
LABEL version="${VERSION}"
