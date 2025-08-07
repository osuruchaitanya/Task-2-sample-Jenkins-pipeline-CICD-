# Use a lightweight Node base image
FROM node:alpine

# Set working directory
WORKDIR /app

# Copy only package files first for caching benefits
COPY package*.json ./

# Install dependencies
RUN npm install

# Now copy the rest of the source code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
