# Set the base image to use for subsequent instructions
FROM node:12.16.2-alpine
RUN apk add g++ make python libtool autoconf automake

# Add metadata to an image 
LABEL app="cypress-conduit"

# Directive to set environmental variables key to value pair
ENV NPM_CONFIG_LOGLEVEL warn

# Set the working directory for any subsequent ADD, COPY, CMD, ENTRYPOINT, 
# or RUN instructions that follow it in the Dockerfile
WORKDIR /usr/src/app

# Copy files or folders from source to the dest path in the image's filesystem.
COPY package.json /usr/src/app/
COPY . /usr/src/app/

# Execute any commands on top of the current image as a new layer and commit the results.
RUN npm install
RUN npm run postinstall

# Define the network ports that this container will listen on at runtime.
EXPOSE 4100
EXPOSE 3000

# Configure the container to be run as an executable.
ENTRYPOINT ["npm", "start"]