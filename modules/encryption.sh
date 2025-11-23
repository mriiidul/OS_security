#!/usr/bin/env bash
# modules/encryption.sh

encrypt_file() {
    log_action "Encryption requested by user"
    read -erp "Enter path of file to encrypt: " target_file
    if [ -z "$target_file" ] || [ ! -f "$target_file" ]; then
        echo "File not found."
        return 1
    fi

    output_file="${target_file}.enc"
    if [ -f "$output_file" ]; then
        echo "Output file already exists: $output_file"
        if ! confirm_action "Overwrite it?"; then
            echo "Aborted."
            return 1
        fi
    fi

    if ! command -v openssl >/dev/null 2>&1; then
        echo "openssl is required. Install it and retry."
        return 1
    fi

    pw=$(read_password "Enter encryption password: ")
    if [ -z "$pw" ]; then
        echo "Empty password not allowed."
        return 1
    fi

    # Encryption with PBKDF2 and iterations
    if openssl enc -"${ENC_ALGO}" -salt -pbkdf2 -iter "$ENC_ITERATIONS" -in "$target_file" -out "$output_file" -pass "pass:$pw"; then
        echo "Encrypted -> $output_file"
        log_action "Encrypted: $target_file -> $output_file"
        if confirm_action "Securely delete original file ($target_file)? (uses shred if available)"; then
            if command -v shred >/dev/null 2>&1; then
                shred -u -z -n 3 -- "$target_file" || rm -f -- "$target_file"
            else
                rm -f -- "$target_file"
            fi
            log_action "Original removed: $target_file"
            echo "Original removed."
        fi
    else
        echo "Encryption failed."
        log_action "Encryption failed: $target_file"
        return 1
    fi
}
