# CI/CD Container Image
# Base image with common CI/CD tools
FROM ghcr.io/astral-sh/uv:0.9.4-python3.12-trixie

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install basic CI/CD tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ssh \
    rsync \
    curl \
    wget \
    unzip \
    zip \
    jq \
    nano \
    tree \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Optional: Install lightweight Node via official script (smaller than apt)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Task
RUN curl -fsSL https://taskfile.dev/install.sh | sh -s -- -d -b /usr/local/bin

# Install common Python packages for CI/CD
# Using trusted hosts to handle SSL issues in some environments
RUN pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org \
    pytest \
    requests \
    pyyaml \
    pre-commit || \
    echo "Warning: Some Python packages may not have been installed due to network issues"

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
