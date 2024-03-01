#!/bin/bash
#


# Build image
echo "Building Image"
docker build -t deb-packager .
docker image list

# Start the container
echo "Starting Packaging Container"
docker run --name deb-packager \
--mount type=bind,source="$(pwd)"/debian,target=/workspace \
-dit deb-packager
docker ps -a

# Run the Packager
echo "Running the Packager"
docker exec deb-packager /workspace/packager.sh 

# Cleanup
echo "Ceaning Up"
docker stop deb-packager
docker rm deb-packager
docker ps -a
