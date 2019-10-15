# Notes for Using Docker

## General tips

Group related `RUN` commands in order to keep them in the same layer (especially deleting files from previous commands).

Swarm:

- Use odd number of managers
- Don't run work on manager nodes (`docker node update --availability drain <NODE>`)

### Dockerfile maturity model

1. Make it start
2. Make it log all things to stdout/stderr
3. Make it documented in file
4. Make it work for others
5. Make it lean
6. Make it scale

### Anti-patterns

1. Trapping data
    - *Problem:* Storing unique data in container
    - **Solution:** Define VOLUME for each location
2. Using `:latest`
    - *Problem:* Image build pull `FROM` latest
    - **Solution:** Use specific `FROM` tags
    - *Problem:* Image builds install latest packages
    - **Solution:** Specify version for critical `apt`/`yum`/`apk` packages
3. Leaving default conifg
    - *Problem:* Not changing app defaults or blindly copying VM conf
    - **Solution:** Update default configs via `ENV`, `RUN` and `ENTRYPOINT`
4. Environment specific
    - *Problem:* Copy in environment config at image build
    - **Solution:** Single Dockerfile with default `ENV`'s and overwrite per-environment with `ENTRYPOINT` script

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

Default file name is `docker-compose.yml`. Override with `docker-compose.override.yml`.

Use a different file with:

    docker-compose -f filename.yml

Multiple files with the ones coming later overriding the previous ones (running in detached mode):

    docker-compose -f base.yml -f override.yml up -d

Setup networks and volumes, start containers:

    docker-compose up

Stop containers and remove networks and volumes:

    docker-compose down

Merge compose files together (and then probably redirect to a third file):

    docker-compose -f first.yml -f second.yml config

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

### Services

For example:

    docker service create alpine ping 8.8.8.8

Add replicas of service:

    docker service update SERVICE --replicas n

Remove service:

    docker service rm SERVICE

More details about a service:

    docker service ps SERVICE

### Networks

Create overlay network:

    docker network create --driver overlay NAME

### Volumes

Use volumes using `--mount`:

    docker service create --mount type=volume,source=volume_name,target=/path/in/container

### Stacks

Deploy using a stack (or update stack):

    docker stack deploy -c STACK_FILE STACK_NAME

List services in stack:

    docker stack services SERVICE

List processes in stack:

    docker stack ps SERVICE

Remove stack:

    docker stack rm STACK

### Secrets

Secrets are:

- Usernames and passwords
- Certificates and keys
- Confidential data

Create secret:

    docker secret create SECRET [file]

List secrets:

    docker secret ls

Create a service that uses the secret (example):

    docker service create --name psql --secret psql_user --secret psql_pass -e POSTGRES_PASSWORD_FILE=/run/secrets/psql_pass -e POSTGRES_USER_FILE=/run/secrets/psql_user postgres

Remove a secret:

    docker service update --secret-rm SECRET

### Updates

Update image to newer version:

    docker service update --image myapp:1.2.1 SERVICENAME

Add and environment variable and remove a port:

    docker service update --env-add NODE_ENV=production --publish-rm 8080

Change number of replicas for multiple services:

    docker service scale web=8 api=6

Rebalance swarm (e.g. after adding nodes or making large changes):

    docker service update --force SERVICE

## Healthchecks

Healthchecks show up when using `docker container ls`. Last 5 healthcheck results show up when using `docker container inspect`. Services replce tasks if the tasks fail a healthcheck. Updates wait for a healthcheck before proceeding.

Healthcheck when running a container (example):

    docker container run --name psql -d --health-cmd="pg_isready -U postgres || exit 1" postgres

Healthcheck when running a service (example):

    docker service create --name psql --health-cmd="pg_isready -U postgres || exit 1" postgres

## Registry

Run registry in a container:

    docker container run -d -p 5000:5000 --name registry -v directory/path:/var/lib/registry registry

Pushing and pulling from a registry:

    docker push registry:port/image_name:tag

    docker pull registry:port/image_name:tag
