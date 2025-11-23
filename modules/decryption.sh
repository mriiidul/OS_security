#!/usr/bin/env bash
# modules/decryption.sh

decrypt_file() {
    log_action "Decryption requested by user"
    read -erp "Enter path of encrypted file (.enc): " encrypted_file
    if [ -z "$encrypted_file" ] || [ ! -f "$encrypted_file" ]; then
        echo "Encrypted file not found."
        return 1
    fi

    out_file="${encrypted_file%.enc}"
    if [ -z "$out_file" ]; then out_file="${encrypted_file}.dec"; fi

    if ! command -v openssl >/dev/null 2>&1; then
        echo "openssl is required. Install it and retry."
        return 1
    fi

    pw=$(read_password "Enter decryption password: ")
    if [ -z "$pw" ]; then
        echo "Empty password not allowed."
        return 1
    fi

    if openssl enc -"${ENC_ALGO}" -d -salt -pbkdf2 -iter "$ENC_ITERATIONS" -in "$encrypted_file" -out "$out_file" -pass "pass:$pw"; then
        echo "Decrypted -> $out_file"
        log_action "Decrypted: $encrypted_file -> $out_file"
    else
        echo "Decryption failed (wrong password or file corrupted)."
        log_action "Decryption failed: $encrypted_file"
        return 1
    fi
}
