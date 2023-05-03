#!/bin/bash

set -e

sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
[ "$(whereis flatpak)" != "flatpak:" ] && sudo flatpak update -y 
[ "$(whereis flatpak)" != "flatpak:" ] && sudo flatpak remove --unused
[ "$(whereis snap)" != "snap:" ] && sudo snap refresh
[ "$(whereis python)" != "python:" ] && python -m pip install --upgrade pip
[ "$(whereis python3)" != "python3:" ] && python3 -m pip install --upgrade pip
[ -d "$HOME/.oh-my-zsh" ] && $HOME/.oh-my-zsh/tools/upgrade.sh