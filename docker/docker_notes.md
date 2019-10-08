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

View logs of container (use -f to tail logs):

    docker container logs [OPTIONS] CONTAINER

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

## Docker images

[Docker Hub](https://hub.docker.com)

Pull an image

    docker pull <repository:tag>

View history of image:

    docker image history <repository:tag>

Inspect image:

    docker image inspect <repository:tag>

Assign tags to images:

    docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

Push image to registry:

    docker image push [OPTIONS] NAME[:TAG]

Log in to registry:

    docker login [OPTIONS] [SERVER]

Log out of registry:

    docker logout [SERVER]

Build docker image:

    docker image build [OPTIONS] PATH | URL | -

## Docker administration

Show disk usage:

    docker system df

Remove dangling containers, images and networks:

    docker system prune

Remove all unused containers, images and networks:

    docker system prune -a

## Data volumes and bind mounts

List volumes:

    docker volume ls

Inspect volume:

    docker volume inspect VOLUME

Add volume in Dockerfile:

    VOLUME /path/to/volume

Name a volume when running container (example):

    docker container run -d --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v mysql-db:/var/lib/mysql mysql

Create a volume (if you want to use a specific driver or label):

    docker volume create [OPTIONS] [VOLUME]

Use a bind mount when running:

    docker container run -v /path/on/host:/path/in/container

## Docker Compose

Default file name is `docker-compose.yml`.

Use a different file with:

    docker compose -f filename.yml

Setup networks and volumes, start containers:

    docker-compose up

Stop containers and remove networks and volumes:

    docker-compose down

Rebuild a service:

    docker-compose build [SERVICE]

## Docker Swarm

Initialize a swarm:

    docker swarm init

Initialize a swarm with specific endpoint:

    docker swarm init --advertise-addr IPADDR

List nodes in swarm:

    docker node ls

Change a node's role:

    docker node update --role ROLE NODE 

Get a join token:

    docker swarm join-token ROLE

Leave a swarm:

    docker swarm leave

Docker run for swarms (user `--detach true` when automating):

    docker service COMMAND

For example:

    docker service create alpine ping 8.8.8.8

Add replicas of service:

    docker service update SERVICE --replicas n

Remove service:

    docker service rm SERVICE
