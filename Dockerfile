# Use stable LTS — best compatibility with Baileys stack
FROM node:18-bullseye

# Create app directory
WORKDIR /usr/src/app

# Avoid npm permission + audit noise
ENV NPM_CONFIG_LOGLEVEL=warn
ENV NPM_CONFIG_FUND=false
ENV NPM_CONFIG_AUDIT=false

# Copy only package files first (better layer caching)
COPY package.json package-lock.json* ./

# Clean install with safe flags
RUN npm install --omit=optional --legacy-peer-deps

# Copy project files
COPY . .

# Render expects an exposed port even if unused
EXPOSE 8000

# Start app
CMD ["node", "index.js"]
