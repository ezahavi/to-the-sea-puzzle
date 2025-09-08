# Simple, stable base that Cursor supports
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Tools for node-gyp, ESLint, etc.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl ca-certificates git bash sudo build-essential python3-minimal \
    openssh-client unzip nano \
 && rm -rf /var/lib/apt/lists/*

# Create non-root user 'eitan' with home directory
RUN apt-get update && apt-get install -y --no-install-recommends sudo \
 && useradd -m -s /bin/bash -u 1001 eitan \
 && usermod -aG sudo eitan \
 && echo 'eitan ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/010-eitan-nopasswd \
 && chmod 0440 /etc/sudoers.d/010-eitan-nopasswd

# Create the working directory and set ownership to eitan
# RUN mkdir -p /workspace && chown -R eitan:eitan /workspace && chmod -R 777 /workspace

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y nodejs \
 && npm --version && node --version
 
# Install Vue CLI globally
RUN npm install -g @vue/cli

# Create app directory
# WORKDIR /workspace

# [Optional] Pre-install project dependencies (comment out if you prefer volume mapping)
# COPY package*.json ./
# RUN npm install

# Set default user (root is fine, but you can create non-root if desired)
USER root
