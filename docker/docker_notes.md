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

To run a stopped container (i.e. a container that was already run before) use:

    docker container start <ID or name>

List all running containers:

    docker container ls

List _all_ containers:

    docker container ls -a

Stop container with ID (you only need to specify enough characters to identify a single container):

    docker container stop <ID or name>

View logs of container:

    docker container logs <ID or name>

List the running processes of a container:

    docker container top <ID or name>

Stop a container:

    docker container stop <ID or name>

Remove containers (force with `-f` flag):

    docker container rm <ID/name...>

List all images:

    docker image ls
