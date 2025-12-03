#!/usr/bin/env bash

analyze_and_block() {

    echo "Scanning failed login attempts..."
    sleep 1

    if [ ! -f "$SYS_AUTH_LOG" ]; then
        echo "Auth log not found at $SYS_AUTH_LOG"
        return 1
    fi

    grep -Ei "Failed password|authentication failure|invalid user" "$SYS_AUTH_LOG" > "$DATA_DIR/raw_fails.txt"

    if [ ! -s "$DATA_DIR/raw_fails.txt" ]; then
        echo "No failed login attempts found."
        return 0
    fi

    grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$DATA_DIR/raw_fails.txt" > "$DATA_DIR/ip_only.txt"

    if [ ! -s "$DATA_DIR/ip_only.txt" ]; then
        echo "No attacker IPs extracted."
        return 0
    fi

    sort "$DATA_DIR/ip_only.txt" | uniq -c | sort -nr > "$DATA_DIR/ip_fail_count.txt"

    echo ""
    echo "===== Failed Login Attempts Detected ====="
    cat "$DATA_DIR/ip_fail_count.txt"
    echo "=========================================="
    echo ""

    THRESHOLD=3

    while read -r count ip; do
        count=$(echo "$count" | xargs)
        ip=$(echo "$ip" | xargs)

        if [[ "$count" =~ ^[0-9]+$ ]]; then
            if [ "$count" -ge "$THRESHOLD" ]; then
                echo "IP $ip has $count failed attempts — BLOCKING..."
                block_ip "$ip"
            fi
        fi
    done < "$DATA_DIR/ip_fail_count.txt"

    log_action "Brute-force scan complete"
    echo "Scan complete."
}

