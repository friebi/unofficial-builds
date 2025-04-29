FROM ubuntu:24.04

ARG GID=1000
ARG UID=1000

RUN groupadd --gid $GID node \
    && useradd --gid $GID --uid $UID --comment node node

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && apt-get update \
    && apt-get install -y \
         git \
         curl \
         g++-12 \
         gcc-12 \
         gcc-12-multilib \
         g++-12-multilib \
         make \
         ccache \
         xz-utils

RUN git clone --depth=1 https://github.com/rvagg/rpi-newer-crosstools \
    /opt/rpi-newer-crosstools/

COPY --chown=node:node run.sh /home/node/run.sh

VOLUME /home/node/.ccache
VOLUME /out
VOLUME /home/node/node.tar.xz

USER node

ENTRYPOINT [ "/home/node/run.sh" ]
