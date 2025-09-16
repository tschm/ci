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
    ca-certificates

# Install uv/uvx
RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && export PATH="/root/.local/bin:$PATH"

# Install tectonic
RUN apt-get install -y --no-install-recommends \
    xz-utils \
    fontconfig \
    libfreetype6 \
    libgraphite2-3 \
    libharfbuzz0b \
    libpng16-16 \
    libx11-6 \
    libxext6 \ 
    libxrender1 \
    perl \
    && rm -rf /var/lib/apt/lists/* \
    && curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh \
    && export PATH=$PWD:$PATH

# Install common Python packages for CI/CD
# Using trusted hosts to handle SSL issues in some environments
RUN pip3 install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org \
    pytest \
    requests \
    pyyaml || \
    echo "Warning: Some Python packages may not have been installed due to network issues"

# Create a non-root user for security
RUN useradd -m -s /bin/bash ciuser

# Set working directory
WORKDIR /workspace

# Change ownership of workspace to ciuser
RUN chown ciuser:ciuser /workspace

# Switch to non-root user
USER ciuser

# Default command
CMD ["/bin/bash"]

# Labels for metadata
LABEL maintainer="Thomas Schmelzer"
LABEL description="CI/CD container with common tools and utilities"
#LABEL version="1.0.0"
