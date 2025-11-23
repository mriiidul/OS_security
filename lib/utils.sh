#!/usr/bin/env bash
# lib/utils.sh - utility helpers

# Colors (safe default if not a tty)
if [ -t 1 ]; then
    RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'
else
    RED=''; GREEN=''; YELLOW=''; BLUE=''; CYAN=''; NC=''
fi

show_banner() {
    echo -e "${CYAN}======================================${NC}"
    echo -e "${GREEN}   OS SECURITY & PROTECTION SYSTEM${NC}"
    echo -e "${CYAN}======================================${NC}"
}

log_action() {
    # log_action "message"
    mkdir -p "$(dirname "$AUDIT_LOG")"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$AUDIT_LOG"
}

require_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}This action requires root privileges. Run with sudo.${NC}"
        return 1
    fi
    return 0
}

confirm_action() {
    # confirm_action "Prompt"
    local prompt="$1"; local reply
    read -rp "$prompt [y/N]: " reply
    case "$reply" in
        [Yy]* ) return 0 ;;
        * ) return 1 ;;
    esac
}

# Safe read password
read_password() {
    # prints password to stdout (so caller can capture)
    # Usage: pass=$(read_password "Enter password: ")
    local prompt="${1:-Enter password: }"
    local pw
    read -rsp "$prompt" pw
    echo
    printf "%s" "$pw"
}
