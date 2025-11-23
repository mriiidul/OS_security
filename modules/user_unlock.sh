#!/usr/bin/env bash
# modules/user_unlock.sh

unlock_user() {
    read -rp "Enter username to unlock: " target_user
    if ! id "$target_user" >/dev/null 2>&1; then
        echo "User does not exist."
        return 1
    fi

    if passwd -u "$target_user"; then
        echo "User $target_user unlocked."
        log_action "Unlocked user: $target_user"
    else
        echo "Failed to unlock user $target_user."
        log_action "Failed to unlock user: $target_user"
        return 1
    fi
}
