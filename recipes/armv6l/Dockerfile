# FROM debian:trixie-slim
FROM ubuntu:26.04

ARG GID=1000
ARG UID=1000

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
        python3 \
        git \
        curl \
        make \
        ccache \
        xz-utils \
        clang-22:i386 \
        lld-22:i386 \
        crossbuild-essential-armhf \
        libstdc++-14-dev:i386 \
        libstdc++-14-dev-armhf-cross \
        libgcc-14-dev:i386 \
        libgcc-14-dev-armhf-cross \
        libatomic1:i386 \
        libatomic1-armhf-cross

COPY --chown=ubuntu:ubuntu run.sh /home/ubuntu/run.sh

VOLUME /home/ubuntu/.ccache
VOLUME /out
VOLUME /home/ubuntu/node.tar.xz

USER ubuntu

ENTRYPOINT [ "/home/ubuntu/run.sh" ]
