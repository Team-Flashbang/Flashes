FROM --platform=linux/arm64 ghcr.io/team-flashbang/flashes/base/debian:bullseye

# Set Metadata
LABEL authors="Team Flashbang" maintainer="dev@fb-hosting.net"
LABEL org.opencontainers.image.source="https://github.com/Team-Flashbang/Flashes"
RUN date > /build.time # store build time

ENV DEBIAN_FRONTEND noninteractive

# add dependencies
RUN dpkg --add-architecture i386 && \
    dpkg --add-architecture armhf && \
    apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends  \
        libgcc1 \
        libcurl4-gnutls-dev:i386 \
        libssl1.1:i386 \
        libatomic1 \
        libpulse-dev \
        libpulse0 \
        libcurl4:i386 \
        libtinfo6:i386 \
        libncurses5:i386 \
        libcurl3-gnutls:i386 \
        libsdl2-2.0-0:i386 \
        libsdl1.2debian \
        libfontconfig1 \
        libc++-dev \
        libc6 \
        libsdl2-2.0-0 \
        libcurl3-gnutls \
        libnss-wrapper \
        gcc-arm-linux-gnueabihf \
        libc6:armhf \
        libncurses5:armhf \
        libstdc++6:armhf

## Prepare NSS Wrapper for the entrypoint as a workaround for Valheim requiring a valid UID
ENV NSS_WRAPPER_PASSWD=/tmp/passwd
ENV NSS_WRAPPER_GROUP=/tmp/group
RUN touch ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP} && \
    chgrp 0 ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP}  && \
    chmod 777 ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP}
ADD passwd.template /passwd.template

# Configure User
RUN useradd -m -d /home/container -s /bin/bash container
ENV USER=container HOME=/home/container
WORKDIR /home/container
USER container

COPY entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]