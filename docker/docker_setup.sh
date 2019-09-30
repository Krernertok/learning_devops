#!/bin/bash

# install Docker using the script found at https://get.docker.com
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# add user to "docker" group to avoid using sudo for each command
# exercise caution! https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
sudo usermod -aG docker $your_user

# install Docker Machine as described at https://docs.docker.com/machine/install-machine/
base=https://github.com/docker/machine/releases/download/v0.16.0 &&
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
chmod +x /usr/local/bin/docker-machine

# install Docker Compose as described at https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose

# start Docker
systemctl start docker
