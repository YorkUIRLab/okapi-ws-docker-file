############################################################
# Dockerfile to build Okapi Installed Containers
# Based on Ubuntu:latest
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Maintaner Sadra Ab <sadrayan@gmail.com>

EXPOSE 8080

# Pre-requisite for compiling Okapi
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y \
	gcc \
	gcc-multilib \
	libc6-i386 \
	make \
	bison \
	flex \
	openjdk-7-jdk:i386 \
	git \
	maven \
	vim

# jdk 7 and gcc 4.8
RUN cp /usr/lib/jvm/java-7-openjdk-i386/include/jni.h /usr/lib/gcc/x86_64-linux-gnu/4.8/include
RUN cp /usr/lib/jvm/java-7-openjdk-i386/include/jni_md.h /usr/lib/gcc/x86_64-linux-gnu/4.8/include

RUN mkdir -p /home/okapi
RUN git clone https://github.com/YorkUIRLab/okapi.git /home/okapi
RUN git clone https://github.com/YorkUIRLab/okapi-web-service.git /home/okapi-web-service
RUN git config --global user.email "sadrayan@gmail.com"
RUN git config --global user.name "sadrayan"

# initialize okapi
RUN /home/okapi/scripts/init.sh

# Setup env variables
RUN cp /home/okapi/environmentSettings.bshrc ~/.bashrc
RUN /bin/bash -c 'source ~/.bashrc ; echo $OKAPI_BINDIR'

# run Okapi WS
RUN /home/okapi-web-service/init.sh

WORKDIR /home/okapi
