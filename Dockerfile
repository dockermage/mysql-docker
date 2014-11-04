FROM dockermage/baseimage:latest
MAINTAINER Vlad Fratila <vlad.fratila@gmail.com>

ENV DOCKER_DISABLE_SSH 1
RUN mkdir /build-mysql
ADD . /build-mysql

RUN /build-mysql/install-mysql.sh && \
	/build/cleanup.sh

VOLUME  ["/var/log/mysql", "/var/lib/mysql"]
EXPOSE 3306