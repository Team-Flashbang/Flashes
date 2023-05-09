#!/bin/bash

export APP=1690800
export TARGET=/mnt/server

# Download requirements...
apt update
apt install -y --no-install-recommends \
  ca-certificates \
  locales \
  curl \
  gpg

# Install Box64
curl -o /etc/apt/sources.list.d/box64.list -L https://ryanfortner.github.io/box64-debs/box64.list
curl -sSL https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg
apt update
apt install -y -qq --no-install-recommends box64

# Install Box86
dpkg --add-architecture armhf
curl -o /etc/apt/sources.list.d/box86.list -L https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list
curl -sSL https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg
apt update
apt install -y -qq --no-install-recommends \
  libc6:armhf \
  box86:armhf

# Set the locale
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen
locale-gen

# Download and install SteamCMD
mkdir /opt/valve
curl -sSL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zxvf - -C /opt/valve

# SteamCMD fails otherwise for some reason, even running as root.
# This is changed at the end of the install process anyways.
chown -R root:root /mnt
export HOME=/mnt/server

# Install Game
DEBUGGER=box86 /opt/valve/steamcmd.sh +quit
DEBUGGER=box64 /opt/valve/steamcmd.sh \
  +force_install_dir $TARGET \
  +login anonymous \
  +app_update $APP validate \
  +quit

# Update 32 bit libraries
mkdir -p /mnt/server/.steam/sdk32
cp -v /opt/valve/linux32/steamclient.so /mnt/server/.steam/sdk32/steamclient.so

# Update 64 bit libraries
mkdir -p /mnt/server/.steam/sdk64
cp -v /opt/valve/linux64/steamclient.so /mnt/server/.steam/sdk64/steamclient.so

echo "Nice! A wild Satisfactory Server appeared."