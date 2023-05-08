#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt update
apt install -y --no-install-recommends ca-certificates curl gnupg curl podman grep;

sed -i "s/# unqualified-search-registries.*/unqualified-search-registries\ =\ [\"docker.io\"]/" /etc/containers/registries.conf


image=tiltedphoques/st-reborn-server:latest

container=$(podman create $image)
podman cp ${container}://home/server/. ./mnt/server

ls /usr/lib/aarch64-linux-gnu | grep libstdc
cp /usr/lib/aarch64-linux-gnu/libstdc++.so.6 /mnt/server/libstdc++.so.6

echo "Nice! A wild SkyrimTogether Server appeared."