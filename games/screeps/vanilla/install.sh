#!/bin/bash
export TARGET=/mnt/server
export DOWNLOAD_URL=https://github.com/screepers/screeps-launcher/releases/download/v1.14.0/screeps-launcher_v1.14.0_linux_arm64
export DEBIAN_FRONTEND=noninteractive

# download requirements...
apt update
apt install -y --no-install-recommends \
  ca-certificates \
  curl

# link 'python' to 'python2'. Required to fix node-gyp
ln -s /usr/bin/python2 /usr/bin/python

# download screeps-launcher
curl -L -o $TARGET/screeps-launcher https://github.com/screepers/screeps-launcher/releases/download/v1.14.0/screeps-launcher_v1.14.0_linux_arm64
chmod +x $TARGET/screeps-launcher

# write config
cat <<EOT >> $TARGET/config.yml
# See: https://github.com/screepers/screeps-launcher
steamKey: <YourSteamKey>
version: latest
mods:
- screepsmod-auth
- screepsmod-admin-utils
bots:
  simplebot: "screepsbot-zeswarm"
serverConfig:
  welcomeText:  |
    <style>.screeps h1{  text-align: center; }</style>
    <div class="screeps">
    <h1>Screeps</h1>
    Welcome to my Screeps Server
    </div>
  tickRate: 1000
EOT

echo "Nice! A wild Screeps: World Server appeared."