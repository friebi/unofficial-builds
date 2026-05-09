FROM debian:bookworm-slim

ARG GID=1000
ARG UID=1000

RUN groupadd --gid $GID node \
    && useradd --gid $GID --uid $UID --comment node node

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
    && apt-get install -y \
        crossbuild-essential-armhf \
        libstdc++-12-dev-armhf-cross \
        libgcc-12-dev-armhf-cross \
        libatomic1-armhf-cross \
    && apt-get install -y \
        clang-19:i386 \
        lld-19:i386 \
        libstdc++-12-dev:i386 \
        libgcc-12-dev:i386 \
        libatomic1:i386

COPY --chown=node:node run.sh /home/node/run.sh
COPY --chown=node:node enable-armv6.patch /home/node/enable-armv6.patch

VOLUME /home/node/.ccache
VOLUME /out
VOLUME /home/node/node.tar.xz

USER node

ENTRYPOINT [ "/home/node/run.sh" ]
