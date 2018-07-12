FROM rhoot/wine32

LABEL Author="Mingshi Cai i@unoiou.com"
LABEL Version="1.0.0"
LABEL Description="Electron continuous integration image."

# install libs
RUN dnf update -y && \
    dnf install Xvfb -y && \
    dnf install gtk3 gtk2 -y && \
    dnf install xorg-x11-xkb-utils xorg-x11-apps -y && \
    dnf install libXScrnSaver GConf2 -y

# install latest nodejs and npm environment, must in one RUN to share context
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - && \
    dnf install nodejs -y && node --version && \
    # nodejs 8.10.x actually downgrades npm to 5.6.0, upgrade npm
    npm install npm -g && npm --version
    # whereis npm && ln -s /usr/lib/node_modules/npm/bin/npm-cli.js /bin/npm && npm --version
    # install electron

RUN npm i -g electron --unsafe-perm=true --allow-root && \
    # set machine-id. uuid can generated from uuid
    echo 0a32214883ec11e89dc10242ac110003 > /etc/machine-id

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

VOLUME ["/code"]
WORKDIR code
