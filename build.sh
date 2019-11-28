#!/bin/bash

# declare the environment variables
declare -r IMAGE_NAME="go-api-toy"
declare -r IMAGE_TAG="latest"
declare -r APP_PORT="3000"

echo    # line break

build () {
    # build the image according to the specifications
    echo "Building image '$IMAGE_NAME:$IMAGE_TAG'..."
    python3 docker/dockerfile_template.py \
        -f docker/Dockerfile \
        --app_name=$IMAGE_NAME \
        --port=$APP_PORT \
    | docker build -t $IMAGE_NAME:$IMAGE_TAG -
}

run () {
    # start the docker executable image
    echo "Starting '$IMAGE_NAME:$IMAGE_TAG', on $APP_PORT/tcp"
    docker run -p $APP_PORT:$APP_PORT $IMAGE_NAME:$IMAGE_TAG
}


print_usage () {
    printf "USAGE: please provide arguments\n \
    -b/--build : build the docker image\n \
    -r/--run : run the docker executable\n"
    echo
}

main () {
    if [[ $# -eq 0 ]]; then
        build
        run
    fi
    while [[ $# -gt 0 ]]; do
        key="$1"
        echo "hello"
        case key in
            -b|--build)
                build
                shift
                ;;
            -r|--run)
                run
                shift
                ;;
            *)
                echo "Unknown option $key"
                print_usage
                shift
                ;;
        esac;
    done
}

main