NAME = aospan/gstreamer-vaapi
VERSION = 0.0.1

.PHONY: all build 

all: build

build:
	docker build -t $(NAME) .
	docker run -v `pwd`/opt:/opt -it $(NAME) /opt/build-gstreamer-vaapi.sh

run:
	docker run --privileged -v `pwd`/opt:/opt -v /dev:/dev -it $(NAME) /bin/bash
