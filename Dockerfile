# Use a specific version of Node.js for better consistency
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Expose the port on which the app will run
EXPOSE 8080

# Define the command to run the app
CMD ["npm", "start"]
