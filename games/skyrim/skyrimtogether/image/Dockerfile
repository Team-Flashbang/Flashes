FROM --platform=linux/arm64 ghcr.io/team-flashbang/flashes/base/debian:bullseye

# Set Metadata
LABEL authors="Team Flashbang" maintainer="dev@fb-hosting.net" org.opencontainers.image.source="https://github.com/Team-Flashbang/Flashes"
RUN date > /build.time # store build time

ENV DEBIAN_FRONTEND noninteractive

# add dependencies
RUN dpkg --add-architecture i386 && \
    dpkg --add-architecture armhf && \
    apt update && \
    apt upgrade -y



# Configure User
RUN useradd -m -d /home/container -s /bin/bash container
ENV USER=container HOME=/home/container
WORKDIR /home/container
USER container

COPY entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]