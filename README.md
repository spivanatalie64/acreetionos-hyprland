# AcreetionOS Hyprland Edition

## Discontinued — Archived

**This edition is abandoned. This repository is archived and read-only. No builds, updates, fixes, or support will happen here.**

### Why we dropped the Wayland editions

AcreetionOS has one job: hand ordinary people an Arch-based desktop they can actually live in. Every edition is measured against that promise, and this one failed it fastest of all — Hyprland's pace of change meant an ISO could be outdated before it finished downloading.

The Wayland stack never reached the bar we hold the rest of the distro to:

- **Never stable enough.** Sessions refused to start on everyday hardware, crashes took the whole session down instead of one window, and configuration formats changed between releases often enough to break people's setups repeatedly. A desktop that punishes users for updating is not stable.
- **Ease of access went backwards.** Screen readers, on-screen keyboards, remote assistance, and multi-monitor setups regressed under Wayland on exactly the machines our community actually runs.
- **Never easy enough for normal people.** Recovering from a bad session meant environment variables, compositor flags, config-file migrations, and log archaeology. That is developer work. We will not ask non-technical users to do it just to see a desktop.

Put together, that goes against the core of the AcreetionOS mission. Rather than ship editions we cannot stand behind, effort now goes into the proven X11/XLibre desktops — Cinnamon, MATE, Xfce, Openbox, i3 — where AcreetionOS delivers the experience its name promises.

If you relied on this edition, the standard ISO covers the same ground on X11 today and keeps improving there.

Everything below is kept for reference only, frozen under GPL-3.0 as it shipped.

---

Hyprland Wayland Compositor Community Edition.

> Self-contained archiso profile. Builds standalone from standard Arch mirrors.

## Build (historical)

```bash
git clone https://github.com/spivanatalie64/acreetionos-hyprland.git
cd acreetionos-hyprland
./build.sh
```

ISO lands in `./ISO/`. CI builds weekly and on push, then publishes a GitHub
release with the ISO asset.

## Layout

| Path | Purpose |
|------|---------|
| `profiledef.sh` | Edition metadata |
| `packages.x86_64` | Static package list |
| `pacman.conf` | Standard Arch mirrors |
| `airootfs/` | Live-environment overlay (DM, configs) |
| `.github/workflows/` | CI: ISO build + lint + release |

## Community

- **Discord:** AcreetionOS Community Server
- **Website:** https://acreetionos.org
