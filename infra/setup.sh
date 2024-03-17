#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 --api-key YOUR_API_KEY"
    exit 1
}

# Check if no arguments provided
if [ $# -eq 0 ]; then
    usage
fi

# Parse arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --api-key)
            PREFECT_API_KEY="$2"
            shift # past argument
            shift # past value
            ;;
        --env)
            ENV="$2"
            shift # past argument
            shift # past value
            ;;
        *)
            # Unknown argument
            echo "Unknown argument: $1"
            usage
            ;;
    esac
done

# Check if API key is provided
if [ -z "$PREFECT_API_KEY" ] || [ -z "$ENV" ]; then
    echo "Error: Both API key (--api-key) and environment (--env) must be provided"
    usage
fi

# Your script logic using API_KEY goes here
echo "API key provided!"

PREFECT_WORKSPACE_ID='cc7b058b-5722-4f9e-a406-7e19236856cb'
PREFECT_ACCOUNT_ID='ab0d6153-67a2-40ef-8e0c-2b1a8e25b401'


echo 'building the prefect worker!'

# build the image using the root folder as the build context
docker build -t prefect-worker -f ../Dockerfile ..

# start the worker container!
docker run --rm --name prefect-worker \
  -e ENV="$ENV" \
  -e PREFECT_API_KEY="$PREFECT_API_KEY" \
  -e PREFECT_WORKSPACE_ID="$PREFECT_WORKSPACE_ID" \
  -e PREFECT_ACCOUNT_ID="$PREFECT_ACCOUNT_ID" \
  prefect-worker