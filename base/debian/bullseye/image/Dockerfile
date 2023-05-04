FROM --platform=linux/arm64 debian:bullseye-slim

# Set Metadata
LABEL authors="Team Flashbang" maintainer="dev@fb-hosting.net"
RUN date > /build.time # store build time

ENV DEBIAN_FRONTEND noninteractive

# Update System
RUN apt update && \
    apt full-upgrade -y

# Install commond dependencies
RUN apt install -y --no-install-recommends \
    tar \
    curl \
    locales \
    ca-certificates \
    gpg \
    iproute2 \
    gcc \
    gdb \
    g++ \
    gettext \
    mono-runtime

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

# Install Box64
RUN curl -o /etc/apt/sources.list.d/box64.list -L https://ryanfortner.github.io/box64-debs/box64.list && \
    curl -sSL https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg && \
    apt update && \
    apt install -y -qq --no-install-recommends box64

# Install Box86
RUN dpkg --add-architecture armhf && \
    curl -o /etc/apt/sources.list.d/box86.list -L https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list && \
    curl -sSL https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg && \
    apt update && \
    apt install -y -qq --no-install-recommends libc6:armhf box86:armhf

# Clean Image
RUN rm -rf /var/lib/apt/lists/*