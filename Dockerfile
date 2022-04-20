FROM pdr.nephatrine.net/nephatrine/alpine-s6:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== INSTALL PACKAGES ======" \
 && apk add --no-cache jq libxml2-utils openjdk17-jre screen

COPY override /

EXPOSE 25565/tcp 25566/udp
