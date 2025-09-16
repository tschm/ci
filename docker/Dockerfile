# Use a lightweight Debian base
FROM debian:bookworm-slim
LABEL authors="thomasschmelzer"

# Avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      curl \
      ca-certificates \
      git \
      bash \
      sed \
      gawk \
      findutils \
      python3 \
      python3-pip \
      unzip \
      yamllint \
      && rm -rf /var/lib/apt/lists/*

# Install uv (and optionally uvx if needed)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Install Tectonic (for LaTeX builds)
RUN curl -LsSf https://tectonic-typesetting.github.io/install.sh | sh

# Set workdir
WORKDIR /workspace

# Default entrypoint
ENTRYPOINT ["/bin/bash"]