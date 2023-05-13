FROM --platform=linux/arm64 ghcr.io/team-flashbang/flashes/base/debian:bullseye

# Set Metadata
LABEL authors="Team Flashbang" maintainer="dev@fb-hosting.net" org.opencontainers.image.source="https://github.com/Team-Flashbang/Flashes"
RUN date > /build.time # store build time

ENV DEBIAN_FRONTEND noninteractive

# add dependencies
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        build-essential \
        python3 \
        python2 \
        tcl \
        git

# link 'python' to 'python2'
RUN ln -s /usr/bin/python2 /usr/bin/python

# Configure User
RUN useradd -m -d /home/container -s /bin/bash container
ENV USER=container HOME=/home/container
WORKDIR /home/container
USER container

COPY entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]