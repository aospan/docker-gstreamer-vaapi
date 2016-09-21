NAME = aospan/gstreamer-vaapi
VERSION = 0.0.1

.PHONY: all build 

all: build

build:
	docker build -t $(NAME) .
	docker run -v `pwd`/opt:/opt -it $(NAME) /opt/build-gstreamer-vaapi.sh

run:
	docker run --privileged -v `pwd`/html:/var/www/html -v `pwd`/opt:/opt -v /dev:/dev -p 8080:80 -it $(NAME) /bin/bash
