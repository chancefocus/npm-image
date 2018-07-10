FROM rhoot/wine32

LABEL Author="Mingshi Cai i@unoiou.com"
LABEL Version="1.0.0"
LABEL Description="Electron continuous integration image."

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

# install libs
RUN dnf update && \
    dnf install Xvfb -y && \
    dnf install xorg-x11-xkb-utils xorg-x11-apps -y && \
    dnf install gkt3 -y && \
    dnf install libXScrnSaver -y && \
    dnf install GConf2 -y

# install latest nodejs on Fedora
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - && \
    dnf install -y nodejs

# nodejs 8.10.x actually downgrades npm to 5.6.0, upgrade npm
RUN npm i npm -g

# install electron
RUN npm i -g electron --unsafe-perm=true --allow-root

# set machine-id uuid can generated from uuid
RUN echo 0a32214883ec11e89dc10242ac110003 > /etc/machine-id

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

VOLUME ["/code"]
WORKDIR code
