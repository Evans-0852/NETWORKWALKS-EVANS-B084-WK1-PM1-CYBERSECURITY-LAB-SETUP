#!/usr/bin/env bash
# Fix for DAD delay causing no connectivity (VirtualBox 7 + newer Kali).
set -euo pipefail
CON="${1:-Wired connection 1}"
[[ $EUID -eq 0 ]] || { echo "Run with sudo."; exit 1; }
nmcli connection modify "$CON" ipv4.dad-timeout 0
nmcli connection down "$CON" || true
nmcli connection up "$CON"
echo "Done. Reboot if the problem persists."
