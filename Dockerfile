FROM rhoot/wine32

LABEL Author="Jimin Huang huangjimin@whu.edu.cn"
LABEL Version="1.0.0"
LABEL Description="Fedora based electron continuous integration image."

ENV PACKAGES="\
    dumb-init \
    tar \
    bash \
    git \
    openssh \
    curl \
    gcc \
    g++ \
    gfortran \
    build-base \
    wget \
"

RUN dnf update && \
    curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - && \
    dnf install -y nodejs && \
    npm update -g npm

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

VOLUME ["/code"]
WORKDIR code
