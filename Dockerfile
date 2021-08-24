FROM nephatrine/alpine-s6:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== INSTALL PACKAGES ======" \
 && apk add \
   jq \
   libxml2-utils \
   openjdk8-jre \
   screen \
 && rm -rf /var/cache/apk/*

COPY override /
EXPOSE 25565/tcp
