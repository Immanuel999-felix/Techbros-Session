# Use Node.js 20 (Slim version is faster and lighter)
FROM node:20-bullseye-slim

# Set working directory
WORKDIR /usr/src/app

# Copy package files first
COPY package*.json ./

# Install dependencies (ignoring optional ones to prevent errors)
RUN npm install --no-optional

# Copy the rest of the files
COPY . .

# Expose the port
EXPOSE 8000

# Start the bot directly (This matches the new package.json)
CMD ["node", "index.js"]
