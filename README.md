# Example: Simple Go API in a Docker container

A template project to create a Docker image for a Go application.
The example application exposes an HTTP endpoint.

The Docker build uses a [multi-stage build setup](https://docs.docker.com/develop/develop-images/multistage-build/)
to minimize the size of the generated Docker image.  The Go build uses [dep](https://github.com/golang/dep) for
dependency management.

# Explanation

The code is written on the local system then copied into the docker builder.  
The builder is then , but the docker image is used to compile then run the code.  
The only requirement for running this example is that docker is installed.

# Trickery

Because I don't like hardcoding names into my dockerfile, I'm using python to do template substitution in the dockerfile.  I know that's probably not standard but I want all the configuration to be ingested through 

# Usage and Demo

**Step 1:** Create the Docker image according to [Dockerfile](Dockerfile).
This step uses Maven to build, test, and package the [Go application](app.go).
The resulting image is 7MB in size.

```shell
# This may take a few minutes.
$ docker build -t miguno/golang-docker-build-tutorial:latest .
```

**Step 2:** Start a container for the Docker image.

```shell
$ docker run -p 8123:8123 miguno/golang-docker-build-tutorial:latest
```

**Step 3:** Open another terminal and access the example API endpoint.

```shell
$ curl http://localhost:8123/status
{"status": "idle"}
```

# Notes

If you need SSL certificates for HTTPS, replace `FROM SCRATCH` in the Docker file with:
```
FROM alpine:3.7
RUN apk --no-cache add ca-certificates
```

# Todo

[ ] Add the dockerfile templating tool
[ ] Get the image to build successfully