#!/usr/bin/env bash
# modules/brute_force_monitor.sh

analyze_bruteforce() {
    if [ -z "${SYS_AUTH_LOG:-}" ]; then
        echo "System auth log not detected on this system."
        return 1
    fi
    if [ ! -r "$SYS_AUTH_LOG" ]; then
        echo "Cannot read $SYS_AUTH_LOG. Try running with sudo."
        return 1
    fi

    echo "Top 5 IPs with failed login attempts (from $SYS_AUTH_LOG):"
    echo "Count  IP"
    grep -Ei "failed password|authentication failure|invalid user" "$SYS_AUTH_LOG" \
        | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' \
        | sort | uniq -c | sort -nr | head -n 5

    log_action "Executed brute-force analysis"
}

view_recent_failures() {
    if [ -z "${SYS_AUTH_LOG:-}" ]; then
        echo "System auth log not detected on this system."
        return 1
    fi
    if [ ! -r "$SYS_AUTH_LOG" ]; then
        echo "Cannot read $SYS_AUTH_LOG. Try running with sudo."
        return 1
    fi

    echo "Last 10 failed authentication lines:"
    grep -Ei "failed password|authentication failure|invalid user" "$SYS_AUTH_LOG" | tail -n 10
    log_action "Viewed recent failures"
}
