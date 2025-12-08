view_recent_failures() {
    echo "====== Recent Failed Login Attempts ======"
    sudo grep -Ei "Failed password|invalid user|authentication failure" /var/log/auth.log | tail -n 20
    echo "=========================================="
}

