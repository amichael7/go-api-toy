# Go Toy API: Simple Golang API Example in a Docker container

A template project to create a Docker image for a Go application.
The example application exposes an HTTP endpoint and 

This project is based on [miguno/golang-docker-build-tutorial](https://github.com/miguno/golang-docker-build-tutorial/)
The Docker build uses a [multi-stage build setup](https://docs.docker.com/develop/develop-images/multistage-build/)
to minimize the size of the generated Docker image.  The Go build uses [dep](https://github.com/golang/dep) for
dependency management.

# Requirements

The only requirement for this running this example is that docker is installed.


# Usage

1. Use the included script to build the image inside the docker container

```shell
./app build
```

1. Use the included script to run the image inside a docker container

```shell
./app run

# or you can specify a port number
# ./app run -p 3000
```

# Explanation

The code is written on the local system then copied into the docker builder.  
The builder is then , but the docker image is used to compile then run the code.  

In order to facilitate the quick deployment of the app, I wrote a shell script for convenience to handle some of the messy internal workings.
The internal configuration (specifically the internal port number, image name, and image tag) are all configured within the app script.

# Tricks

Because I don't like hardcoding names into my dockerfile, I'm using python to do template substitution in the dockerfile.  This is not standard but I want all the docker configuration to be ingested through some kind of logic to make sure everything is working as intended.

# Notes

If you need SSL certificates for HTTPS, replace `FROM SCRATCH` in the Docker file with:
```
FROM alpine:3.7
RUN apk --no-cache add ca-certificates
```

# Todo

[X] Add the dockerfile templating tool
[X] Get the image to build successfully
[X] Launch a working hello world container