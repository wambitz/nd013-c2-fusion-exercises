FROM ubuntu:24.04

# ------------------------------------------------------------------------------
# Build arguments for user/group
# ------------------------------------------------------------------------------
ARG USERNAME=ubuntu
ARG USER_ID=1000
ARG GROUP_ID=1000

# ------------------------------------------------------------------------------
# Create or rename user/group "$USERNAME"
# so that we end up with:
# - group "$USERNAME" at GID=$GROUP_ID
# - user "$USERNAME"  at UID=$USER_ID
# ------------------------------------------------------------------------------
RUN if [ -z "$(getent group $GROUP_ID)" ]; then \
    groupadd -g $GROUP_ID "$USERNAME"; \
  else \
    existing_group="$(getent group $GROUP_ID | cut -d: -f1)"; \
    if [ "$existing_group" != "$USERNAME" ]; then \
      groupmod -n "$USERNAME" "$existing_group"; \
    fi; \
  fi && \
  if [ -z "$(getent passwd $USER_ID)" ]; then \
    useradd -m -u $USER_ID -g $GROUP_ID "$USERNAME"; \
  else \
    existing_user="$(getent passwd $USER_ID | cut -d: -f1)"; \
    if [ "$existing_user" != "$USERNAME" ]; then \
      usermod -l "$USERNAME" -d /home/"$USERNAME" -m "$existing_user"; \
    fi; \
  fi

# ------------------------------------------------------------------------------
# Install dependencies and cleanup
# ------------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    libgtk-3-dev \
    build-essential \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# Optionally add passwordless sudo for $USERNAME
# ------------------------------------------------------------------------------
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ------------------------------------------------------------------------------
# Use sed to uncomment the force_color_prompt line in ~/.bashrc
# ------------------------------------------------------------------------------
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /home/$USERNAME/.bashrc

# ------------------------------------------------------------------------------
# Create the repo mount directory with the right ownership
# ------------------------------------------------------------------------------
RUN mkdir -p /workspaces && \
    chown -R $USERNAME:$USERNAME /workspaces

# ------------------------------------------------------------------------------
# Switch to "$USERNAME" by default
# ------------------------------------------------------------------------------
USER $USERNAME

# ------------------------------------------------------------------------------
# Set repo working directory
# ------------------------------------------------------------------------------
WORKDIR /workspaces

# ------------------------------------------------------------------------------
# Install requirements
# ------------------------------------------------------------------------------
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------
CMD ["/bin/bash"]