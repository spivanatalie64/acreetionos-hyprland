#!/bin/bash
# AcreetionOS Hyprland Edition — build script
set -e
WORK=$(mktemp -d)
ISO_NAME="AcreetionOS-Hyprland-$(date +%Y%m%d)-x86_64.iso"
SCRIPT="/tmp/buildhypr.sh"
OUTDIR="/tmp/ac-hypr-output"
mkdir -p "$OUTDIR"

echo "=== Building $ISO_NAME ==="

cat > "$SCRIPT" << 'INNER'
#!/bin/bash
set -e
pacman -Sy --noconfirm archiso git

git clone https://github.com/acreetionos-code/acreetionos.git /source
cd /source

# Customize for Hyprland
sed -i 's/iso_name=.*/iso_name="AcreetionOS-Hyprland"/' profiledef.sh
sed -i 's/iso_label=.*/iso_label="AC-HYPRLAND"/' profiledef.sh

# Replace package list with Hyprland packages
cat > packages.x86_64 << 'PKGS'
base
base-devel
linux
linux-firmware
grub
efibootmgr
networkmanager
hyprland
hyprpaper
hyprlock
hypridle
waybar
wofi
dunst
kitty
thunar
foot
mako
polkit-kde-agent
qt5-wayland
qt6-wayland
xdg-desktop-portal-hyprland
pipewire
pipewire-pulse
wireplumber
network-manager-applet
firefox
nano
sudo
git
wget
curl
ttf-jetbrains-mono-nerd
noto-fonts
noto-fonts-emoji
PKGS

cat > pacman.conf << 'PACMAN'
[options]
Architecture = x86_64
SigLevel = Never

[core]
Server = https://mirror.archlinux32.org/x86_64/$repo

[extra]
Server = https://mirror.archlinux32.org/x86_64/$repo

[community]
Server = https://mirror.archlinux32.org/x86_64/$repo
PACMAN

# Remove conflicting files before building
find /work -path "*/__pycache__/*" -delete 2>/dev/null || true
mkdir -p /work/x86_64/airootfs 2>/dev/null || true
mkarchiso -v -w /work -o /output .
INNER

chmod +x "$SCRIPT"
docker run --privileged --rm -v "$SCRIPT:$SCRIPT" -v "$OUTDIR:/output" archlinux:latest bash "$SCRIPT" 2>&1

ISO=$(find "$OUTDIR" -name "*.iso" 2>/dev/null | head -1)
if [ -n "$ISO" ]; then
  cp "$ISO" "./$ISO_NAME"
  echo "✓ ISO produced: $ISO_NAME"
else
  echo "No ISO found in $OUTDIR"
  ls -la "$OUTDIR" 2>/dev/null || true
fi
echo "=== Complete ==="
