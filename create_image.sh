#!/bin/bash


# Build image
echo "Building Image"
docker build -t deb-packager .
docker image list


