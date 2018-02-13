#!/bin/bash
set -e

# Create app dir
mkdir app

# Set up Magento
docker run --rm \
  --volume "$(pwd)/app:/app" \
  --volume "$HOME/.composer:/tmp" \
  --user $(id -u):$(id -g) \
  composer create-project \
    --ignore-platform-reqs \
    --repository-url=https://repo.magento.com/ \
    magento/project-community-edition \
    /app
