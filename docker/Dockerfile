# CI/CD Container Image
# Base image with common CI/CD tools
FROM ubuntu:22.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install basic CI/CD tools
RUN apt-get update && apt-get install -y \
    # Basic utilities
    curl \
    wget \
    git \
    unzip \
    zip \
    jq \
    # Build tools
    build-essential \
    # Python and pip
    python3 \
    python3-pip \
    # Node.js and npm
    nodejs \
    npm \
    # Additional useful tools
    tree \
    vim \
    nano \
    ssh \
    rsync \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install common Python packages for CI/CD
# Using trusted hosts to handle SSL issues in some environments
RUN pip3 install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org \
    pytest \
    requests \
    pyyaml || \
    echo "Warning: Some Python packages may not have been installed due to network issues"

# Ensure /usr/local/bin exists and has proper permissions
RUN mkdir -p /usr/local/bin && chmod 755 /usr/local/bin

# Install uv package manager
COPY --from=ghcr.io/astral-sh/uv:0.8.17 /uv /uvx /usr/local/bin/
RUN chmod +x /usr/local/bin/uv \
    && chmod +x /usr/local/bin/uvx \
    && uv --version && uvx --version \

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

# Labels for metadata
LABEL maintainer="Thomas Schmelzer"
LABEL description="CI/CD container with common tools and utilities"
#LABEL version="1.0.0"
