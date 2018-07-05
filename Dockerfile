From frolvlad/alpine-glibc

MAINTAINER Jimin Huang "huangjimin@whu.edu.cn"

ENV PACKAGES="\
    dumb-init \
    bash \
    git \
    openssh \
    curl \
    gcc \
    g++ \
    gfortran \
    build-base \
    wget \
    nodejs \
"

RUN apk update && \
    apk add --update --no-cache $PACKAGES

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

VOLUME ["/code"]
WORKDIR code
