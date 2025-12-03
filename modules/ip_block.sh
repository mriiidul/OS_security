#!/usr/bin/env bash

BLOCKLIST="$DATA_DIR/blocklist.txt"

block_ip() {
    local ip="$1"

    echo "$(date) - $ip" >> "$BLOCKLIST"

    echo "Blocking IP: $ip"
    sudo iptables -A INPUT -s "$ip" -j DROP

    log_action "Blocked IP: $ip"
}

