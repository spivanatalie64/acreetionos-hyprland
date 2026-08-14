#!/usr/bin/env bash
set -euo pipefail
exec mkarchiso -L "acreetionOS_hyprland_202608" -v -o ../ISO . -C ./pacman.conf
