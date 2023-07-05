#!/usr/bin/env bash
set -ex
apt update
cd ~
curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt install nodejs
rm nodesource_setup.sh