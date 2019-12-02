#!/bin/bash

# declare the environment variables
declare -r IMAGE_NAME="go-api-toy"
declare -r IMAGE_TAG="latest"
declare -r APP_PORT="3000"

build() {
    # build the image according to the specifications
    echo "Building image '$IMAGE_NAME:$IMAGE_TAG'..."
    python3 docker/dockerfile_template.py \
        -f docker/Dockerfile \
        --app_name=$IMAGE_NAME \
        --port=$APP_PORT > Dockerfile
    docker build -t $IMAGE_NAME:$IMAGE_TAG .
    rm Dockerfile
}


run() {
    # start the docker executable image
    echo "Starting '$IMAGE_NAME:$IMAGE_TAG', on port $port"
    docker run -p $port:$APP_PORT $IMAGE_NAME:$IMAGE_TAG
}

print_usage() {
# Outputs usage information to console.
cat << EOF

Usage: $(basename "$0") [command] [options]

Utility for running a Golang application in Docker

Commands:
    build       build the docker image
    run         run the docker executable
    help        get usage information

Options:
    -p, --port int          specify a port number to expose for the run command

Running this script without arguments will build then run the image
EOF
}


main() {
    # if there are no arguments, build and run
    if [[ $# -eq 0 ]]; then
        build
        run
    fi

    # If there are commands, parse them
    case $1 in
        build)
            build
            shift
            ;;
        run)
            port=$APP_PORT
            if [[ $2 == "-p" || $2 == "--port" ]]; then
                port=$3
            fi
            run $port
            ;;
        help)
            print_usage
            ;;
        *)
            printf "Unknown option \"$1\"\n"
            print_usage
            ;;
    esac
}

# start the control flow
main $*