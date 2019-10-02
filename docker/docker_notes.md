# Notes for Using Docker

## Information

[Official Docker documentation](https://docs.docker.com)

Basic info (useful when verifying that a fresh install is working properly):

    docker version

More detailed information (e.g. about configuration):

    docker info

## Basic commands

Run a (new) container on host port : container port in detached mode (`--detach` or `-d`):

    docker container run --publish 80:80 --detach nginx

Specify a name using the --name option:

    docker container run --publish 80:80 --name webhost --detach nginx

Run a command in the container and exit (--rm to remove container automatically):

    docker container run --rm <image> <command>

To run a stopped container (i.e. a container that was already run before) use:

    docker container start <container>

List all running containers:

    docker container ls

List _all_ containers:

    docker container ls -a

Stop container with ID (you only need to specify enough characters to identify a single container):

    docker container stop <container>

View logs of container:

    docker container logs <container>

List the running processes of a container:

    docker container top <container>

Stop a container:

    docker container stop <container>

Remove containers (force with `-f` flag):

    docker container rm <ID/name...>

List all images:

    docker image ls

## What's going on in containers

Running processes (recap):

    docker container top

Container metadata:

    docker container inspect <container>

Realtime statistics:

    docker container stats <container>

Start new container interactively:

    docker container run -it

For example:

    docker container run -it --name proxy nginx bash

Restart with bash:

    docker container start -ai <container>

Run additional command in existing container:

    docker container exec -it <flags and arguments>

For example:

    docker container exec -it mysql bash

## Docker networking

[NAT (network address translation)](https://en.wikipedia.org/wiki/Network_address_translation#One-to-many_NAT)

Quick port check:

    docker container port <container>

Actual IP address:

    docker container inspect --format "{{ .NetworkSettings.IPAddress }}" webhost

Show networks:

    docker network ls

Inspect a network:

    docker network inspect <network>

Create a network:

    docker network create --driver

Attach a container to a network:

    docker network connect <network> <container>

Disconnect a container from a network:

    docker network disconnect <network> <container>

Run a container on a specific network:

    docker container run --net <network> <image>

## Docker registry

Pull an image

    docker pull <image name>
