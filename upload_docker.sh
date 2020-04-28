#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=tanyastephens/udacity-capstone

# Step 2:  
# Authenticate & tag
export DOCKER_ID_USER="tanyastephens"
docker login
docker tag udacity-capstone:latest "$DOCKER_ID_USER"/udacity-capstone

# Step 3:
# Push image to a docker repository
docker push tanyastephens/udacity-capstone