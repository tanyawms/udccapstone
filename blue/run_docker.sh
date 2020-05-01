#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Lint the Dockerfile
# This is linter for Dockerfiles
hadolint Dockerfile

# Step 2:
# Build image and add a descriptive tag
docker build -f Dockerfile --tag=udacity-capstone-blue --label=udacity-capstone-blue .

# Step 3:
# List docker images
docker image ls --filter label=udacity-capstone-blue
