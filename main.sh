
#!/usr/bin/env bash
# Sentinix main controller (main.sh)
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config, utils, modules
source "$SCRIPT_DIR/config/settings.conf"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/modules/encryption.sh"
source "$SCRIPT_DIR/modules/decryption.sh"
source "$SCRIPT_DIR/modules/user_lock.sh"
source "$SCRIPT_DIR/modules/user_unlock.sh"
source "$SCRIPT_DIR/modules/brute_force_monitor.sh"

mkdir -p "$DATA_DIR"

log_action "Started Sentinix (main.sh)"

while true; do
    clear
    show_banner
    echo ""
    echo "  1) Encrypt a file"
    echo "  2) Decrypt a file"
    echo "  3) Lock a user account (root required)"
    echo "  4) Unlock a user account (root required)"
    echo "  5) Analyze brute-force attempts (top IPs)"
    echo "  6) View recent failed logins"
    echo "  7) View audit log"
    echo "  8) Exit"
    echo ""

    read -rp "Select an option [1-8]: " CHOICE
    case "$CHOICE" in
        1) encrypt_file ;;
        2) decrypt_file ;;
        3) require_root && lock_user ;;
        4) require_root && unlock_user ;;
        5) analyze_bruteforce ;;
        6) view_recent_failures ;;
        7) cat "$AUDIT_LOG" || echo "No audit log yet." ;;
        8) log_action "Exiting Sentinix" ; echo "Goodbye."; exit 0 ;;
        *) echo "Invalid option." ;;
    esac

    echo ""
    read -rp "Press [Enter] to continue..."
done
