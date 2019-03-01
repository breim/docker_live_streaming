# Docker - Nginx live streaming module

### Usage
Clone docker image

    git clone https://github.com/breim/docker_live_streaming
    cd docker_live_streaming

Build 

    sudo docker build . -t docker_live_streaming

Run docker image

    sudo docker run --name docker_live_streaming -d -p 80:80 -p 1935:1935 docker_live_streaming

Some commands

    sudo docker stop docker_live_streaming
    sudo docker start docker_live_streaming
    sudo docker ps -a
    sudo docker run -it docker_live_streaming bash
    sudo docker exec -it docker_live_streaming bash

View running docker images

    sudo docker container ls
