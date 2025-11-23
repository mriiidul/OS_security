#!/usr/bin/env bash
# modules/user_lock.sh

lock_user() {
    read -rp "Enter username to lock: " target_user
    if ! id "$target_user" >/dev/null 2>&1; then
        echo "User does not exist."
        return 1
    fi

    if passwd -l "$target_user"; then
        echo "User $target_user locked."
        log_action "Locked user: $target_user"
    else
        echo "Failed to lock user $target_user."
        log_action "Failed to lock user: $target_user"
        return 1
    fi
}
