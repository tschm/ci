# CI/CD Container Image
# Base image with common CI/CD tools
FROM ubuntu:22.04

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
    build-essential \
    # Python and pip \
    python3 \
    python3-pip \
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

# Install dependencies for tectonic
RUN apt-get update && apt-get install -y --no-install-recommends \
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
    && rm -rf /var/lib/apt/lists/*

# Install tectonic
RUN curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh || echo "Tectonic installation failed, continuing build" \
    && if [ -f "tectonic" ]; then mv tectonic /usr/local/bin/ && chmod +x /usr/local/bin/tectonic; fi

# Install common Python packages for CI/CD
# Using trusted hosts to handle SSL issues in some environments
RUN pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org \
    pytest \
    requests \
    pyyaml \
    pre-commit || \
    echo "Warning: Some Python packages may not have been installed due to network issues"

# Install uv and uvx from astral-sh image
COPY --from=ghcr.io/astral-sh/uv:0.8.17 /uv /uvx /usr/local/bin/

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
