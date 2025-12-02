#!/usr/bin/env bash

analyze_and_block() {
    if [ ! -f "$SYS_AUTH_LOG" ]; then
        echo "Auth log not found."
        return 1
    fi

    echo "Scanning failed login attempts..."

    grep -Ei "failed password|authentication failure" "$SYS_AUTH_LOG" \
        | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' \
        | sort | uniq -c | sort -nr > "$DATA_DIR/ip_fail_count.txt"

    while read -r count ip; do
        if [ "$count" -ge 3 ]; then
            echo "IP $ip has $count failed attempts — BLOCKING"
            block_ip "$ip"
        fi
done < <(awk '{print $1, $2}'
    "$DATA_DIR/ip_fail_count.txt")

    echo "Scan complete."
    log_action "Performed auto-block scan"
}
