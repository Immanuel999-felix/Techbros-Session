# Use Node 20 (Required for crypto.subtle support in latest Baileys)
FROM node:20-bullseye-slim

# Create app directory
WORKDIR /usr/src/app

# Avoid npm permission + audit noise
ENV NPM_CONFIG_LOGLEVEL=warn
ENV NPM_CONFIG_FUND=false
ENV NPM_CONFIG_AUDIT=false

# Install system dependencies (needed for some crypto/image libraries)
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copy package files first (better layer caching)
COPY package.json package-lock.json* ./

# Clean install with safe flags
RUN npm install --omit=optional --legacy-peer-deps

# Copy project files
COPY . .

# Render expects an exposed port
EXPOSE 8000

# Start app
CMD ["node", "index.js"]
