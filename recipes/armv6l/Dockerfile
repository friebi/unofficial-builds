FROM ubuntu:24.04

ARG GID=1000
ARG UID=1000

# Check if group already exists
RUN if getent group $GID >/dev/null 2>&1; then \
        # If it does, rename it to 'node'
        EXISTING_GROUP=$(getent group $GID | cut --delimiter=: --fields=1); \
        groupmod --new-name node $EXISTING_GROUP; \
    else \
        # If it doesn't, create it with the specified GID
        groupadd --gid $GID node; \
    fi

# Check if user already exists
RUN if id --user $UID >/dev/null 2>&1; then \
        # If it does, rename it to 'node' and change its group to 'node'
        EXISTING_USER=$(getent passwd $UID | cut --delimiter=: --fields=1); \
        usermod --gid $GID --login node $EXISTING_USER; \
    else \
        # If it doesn't, create it with the specified UID and GID
        useradd --gid $GID --uid $UID --comment node node; \
    fi

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
