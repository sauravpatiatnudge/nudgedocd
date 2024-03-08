# Use Node.js as base image
FROM node:latest

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY tools/site/package*.json ./

# Install dependencies
RUN npm install

# Install gulp globally
RUN npm install -g gulp-cli

# Install http-server globally
RUN npm install -g http-server

# Copy the entire project directory into the container
COPY tools/site/ ./

# Build your project (if needed)
RUN gulp build --codelabs-dir=codelabs

RUN rm -rf app tasks codelabs node_modules package*.json gulpfile.js && mv build/* .
# Expose the port your app runs on
EXPOSE 8000

# Define the command to start the HTTP server serving index.html
CMD ["http-server", "-p", "8000"]