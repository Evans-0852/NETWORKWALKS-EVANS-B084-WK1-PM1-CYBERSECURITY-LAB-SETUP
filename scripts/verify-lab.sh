#!/usr/bin/env bash
# Run inside Kali to check lab requirements.
pass=0; fail=0
check() { if eval "$2" >/dev/null 2>&1; then echo "[PASS] $1"; pass=$((pass+1)); else echo "[FAIL] $1"; fail=$((fail+1)); fi; }

check "IP is 10.0.0.2/24"            "ip -4 addr | grep -q '10.0.0.2/24'"
check "Default gateway 10.0.0.1"     "ip route | grep -q 'default via 10.0.0.1'"
check "Ping gateway"                 "ping -c2 -W2 10.0.0.1"
check "Ping Internet (8.8.8.8)"      "ping -c2 -W2 8.8.8.8"
check "DNS resolves (kali.org)"      "getent hosts kali.org"
check "HTTPS works"                  "curl -sI --max-time 8 https://www.kali.org"
check "Shared folder mounted"        "ls /media/sf_Downloads"
check "Guest Additions running"      "pgrep -f VBoxClient || pgrep -f vboxservice"

echo; echo "Passed: $pass  Failed: $fail"
[[ $fail -eq 0 ]]
