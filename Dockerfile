############################################################
# Dockerfile to build Okapi Installed Containers
# Based on Ubuntu:latest
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Maintaner Sadra Ab <sadrayan@gmail.com>

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
	openjdk-7-jdk \
	git \
	maven \
	vim

# jdk  and gcc 4.8
RUN cp /usr/lib/jvm/java-7-openjdk-amd64/include/jni.h /usr/lib/gcc/x86_64-linux-gnu/4.8/include
RUN cp /usr/lib/jvm/java-7-openjdk-amd64/include/jni_md.h /usr/lib/gcc/x86_64-linux-gnu/4.8/include

RUN mkdir -p /home/okapi
RUN git clone https://github.com/YorkUIRLab/okapi.git /home/okapi
RUN git clone https://github.com/YorkUIRLab/okapi-web-service.git /home/okapi_ws
RUN git config --global user.email "sadrayan@gmail.com"
RUN git config --global user.name "sadrayan"

# initialize okapi
RUN /home/okapi/scripts/init.sh

# initialize global variables
#RUN source /home/okapi/environmentSettings.bshrc

#RUN cd /home/okapi_ws/

# Package the Web Service Project
#RUN cd /home/okapi_ws/ && mvn install

# Run Okapi WS - avaiable at localhost:8080
#RUN java -jar target/okapi-web-service-0.1.0.jar



WORKDIR /home/okapi
