# Multi-stage build setup (https://docs.docker.com/develop/develop-images/multistage-build/)

# Stage 1: Create the build image (~850MB)

FROM golang:1.10.1 AS builder
RUN go version

# install python for scripting
RUN apt-get update \
	apt-get install python3 \
	apt-get install python3-pip

COPY app/* /go/src/{{app_name}}/
WORKDIR /go/src/{{app_name}}

RUN set -x && \
    go get github.com/golang/dep/cmd/dep && \
    dep ensure -v

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o {{app_name}} .

# Stage 2: Create the minimal executable image (~7MB)

FROM scratch
WORDIR /root/
COPY --from=builder /go/src/{{app_name}}/{{app_name}} .

EXPOSE {{port}}
ENTRYPOINT ["./{{app_name}}"]
