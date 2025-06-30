# Use official Node.js image
FROM node:20-alpine

# Create non-root user 'eitan' with home directory
RUN apk add --no-cache bash git sudo
RUN adduser -D eitan
RUN echo 'eitan ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Create the working directory and set ownership to eitan
# RUN mkdir -p /workspace && chown -R eitan:eitan /workspace && chmod -R 777 /workspace

# Install bash, git, and other useful tools
RUN apk add --no-cache bash git

# Install Vue CLI globally
RUN npm install -g @vue/cli

# Create app directory
# WORKDIR /workspace

# [Optional] Pre-install project dependencies (comment out if you prefer volume mapping)
# COPY package*.json ./
# RUN npm install

# Set default user (root is fine, but you can create non-root if desired)
USER root
