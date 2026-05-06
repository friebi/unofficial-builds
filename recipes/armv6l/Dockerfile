FROM debian:trixie-slim

ARG GID=1000
ARG UID=1000

RUN groupadd --gid $GID node \
    && useradd --gid $GID --uid $UID --comment node node

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
        python3 \
        git \
        curl \
        make \
        ccache \
        xz-utils \
        clang-19 \
        lld-19 \
        crossbuild-essential-armhf \
        libstdc++-14-dev-i386-cross \
        libstdc++-14-dev-armhf-cross \
        libgcc-14-dev-i386-cross \
        libgcc-14-dev-armhf-cross \
        libatomic1-i386-cross \
        libatomic1-armhf-cross

COPY --chown=node:node run.sh /home/node/run.sh

VOLUME /home/node/.ccache
VOLUME /out
VOLUME /home/node/node.tar.xz

USER node

ENTRYPOINT [ "/home/node/run.sh" ]
