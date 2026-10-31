#!/usr/bin/env bash
# Sets Kali's static IP via NetworkManager. Run inside Kali: sudo ./kali-static-ip.sh
set -euo pipefail
CON="${1:-Wired connection 1}"
IP="10.0.0.2/24"; GW="10.0.0.1"; DNS="8.8.8.8"

[[ $EUID -eq 0 ]] || { echo "Run with sudo."; exit 1; }

nmcli connection modify "$CON" \
  ipv4.method manual ipv4.addresses "$IP" ipv4.gateway "$GW" ipv4.dns "$DNS" \
  ipv4.dad-timeout 0
nmcli connection down "$CON" || true
nmcli connection up "$CON"
ip -4 addr show | grep inet
