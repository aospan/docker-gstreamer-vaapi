NAME = aospan/gstreamer-vaapi
VERSION = 0.0.1

.PHONY: all build 

all: build

build:
	docker build -t $(NAME) .

run:
	docker run --privileged -v /dev:/dev -p 8080:80 -it $(NAME) /bin/bash
