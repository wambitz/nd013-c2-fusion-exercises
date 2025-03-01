#!/usr/bin/env bash
set -e

# ------------------------------------------------------------------------------
# Set build parameters
# ------------------------------------------------------------------------------
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/../..")
DOCKERFILE="Dockerfile"
IMAGE_NAME="sensor-fusion-python-noble-dev"

# ------------------------------------------------------------------------------
# Build the Docker image
# ------------------------------------------------------------------------------
echo "[INFO] Building Docker image '${IMAGE_NAME}' using Dockerfile '${DOCKERFILE}'"

docker build \
  -f "${PROJECT_ROOT}/${DOCKERFILE}" \
  -t "${IMAGE_NAME}" \
  --build-arg USERNAME="$(whoami)" \
  --build-arg USER_UID="$(id -u)" \
  --build-arg USER_GID="$(id -g)" \
  "${PROJECT_ROOT}"
     


