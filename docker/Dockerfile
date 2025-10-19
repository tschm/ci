# ============================================
# CI/CD Container Image - Optimized & Secure
# ============================================
FROM ghcr.io/astral-sh/uv:0.9.4-python3.12-trixie

ENV DEBIAN_FRONTEND=noninteractive

# -------------------------------------------------
# Step 1: System Tools (minimal, no recommends)
# -------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        #git \
        #ssh \
        rsync \
        #curl \
        #wget \
        #unzip \
        zip \
        jq \
        nano \
        tree \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# -------------------------------------------------
# Step 2: Optional Node.js (needed for JS lint/build)
# -------------------------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# -------------------------------------------------
# Step 3: Install Task (Makefile alternative)
# -------------------------------------------------
RUN curl -fsSL https://taskfile.dev/install.sh | sh -s -- -d -b /usr/local/bin

# -------------------------------------------------
# Step 4: Minimal Python CI Tools (via uv pip)
# -------------------------------------------------
RUN uv pip install \
        pytest \
        requests \
        pyyaml \
        pre-commit && \
    rm -rf /root/.cache

# -------------------------------------------------
# Step 5: Add Secure CI User
# -------------------------------------------------
RUN useradd -m -s /bin/bash ciuser

# Default workspace
WORKDIR /workspace
USER ciuser

ENV PATH="/usr/local/bin:${PATH}"

# Metadata
ARG VERSION="dev"
LABEL maintainer="Thomas Schmelzer"
LABEL description="CI/CD container with common tools and utilities"
LABEL version="${VERSION}"

CMD ["/bin/bash"]
