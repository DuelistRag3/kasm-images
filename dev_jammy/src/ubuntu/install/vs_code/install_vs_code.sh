#!/usr/bin/env bash
set -ex
wget -q https://update.code.visualstudio.com/latest/linux-deb-x64/stable -O vs_code_amd64.deb
dpkg -i vs_code_amd64.deb
sed -i 's#/usr/share/code/code#/usr/share/code/code --no-sandbox##' /usr/share/applications/code.desktop
cp /usr/share/applications/code.desktop $HOME/Desktop
chmod +x $HOME/Desktop/code.desktop
chown 1000:1000 $HOME/Desktop/code.desktop
rm vs_code_amd64.deb