FROM ubuntu:16.04

# install required packages
RUN apt-get -y update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository multiverse
RUN apt-get -y update

RUN apt-get install -y autoconf automake bison flex autopoint libtool \
        libglib2.0-dev yasm nasm xutils-dev libpthread-stubs0-dev libpciaccess-dev libudev-dev \
        libfaac-dev libxrandr-dev libegl1-mesa-dev openssh-server git-core wget \
        build-essential gettext libgles2-mesa-dev vim-nox ffmpeg
