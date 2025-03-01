#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/../..")

# ------------------------------------------------------------------------------
# Select image, container names, and Dockerfile
# ------------------------------------------------------------------------------
IMAGE_NAME="sensor-fusion-python-noble-dev"
CONTAINER_NAME="sensor-fusion-python-noble-devcontainer"
HOSTNAME="sensor-fusion-devcontainer"

# ------------------------------------------------------------------------------
# Docker / NVIDIA checks
# ------------------------------------------------------------------------------
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi
 
 if ! docker info | grep -q "Runtimes:.*nvidia"; then
    echo "[WARN] NVIDIA Container Toolkit is not installed or configured."
    echo "GPU acceleration may not work."
    echo "Refer to: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html"
fi

# ------------------------------------------------------------------------------
# Build the Docker image (this calls our new combined build script)
# ------------------------------------------------------------------------------
echo "[INFO] Building Docker image: $IMAGE_NAME"
bash "$SCRIPT_DIR/build_image.sh" 

# ------------------------------------------------------------------------------
# X11 / GPU Setup
# ------------------------------------------------------------------------------
DISPLAY="${DISPLAY:-:0}" 
X11_SOCKET="/tmp/.X11-unix"
# NVIDIA_ICD="/usr/share/vulkan/icd.d/nvidia_icd.json"


# ------------------------------------------------------------------------------
# Start the Docker container
# --volume "$NVIDIA_ICD:$NVIDIA_ICD" \
# ------------------------------------------------------------------------------
echo "[INFO] Starting Docker container..."
docker run -it --rm \
    --name "${CONTAINER_NAME}" \
    --hostname "${HOSTNAME}" \
    --env "DISPLAY=${DISPLAY}" \
    --volume "${X11_SOCKET}:${X11_SOCKET}" \
    --gpus all \
    --volume "${PROJECT_ROOT}:/workspaces" \
    "${IMAGE_NAME}" \
    bash
