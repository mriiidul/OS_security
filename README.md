```markdown
# OS SECURITY & PROTECTION SYSTEM
A Bash-based security automation project designed for Operating System coursework.  
This system analyzes failed login attempts, blocks brute-force attackers automatically, manages user accounts, and provides AES-256 file encryption/decryption — all using shell scripting.

---

## FEATURES

### 1. File Encryption (AES-256)
Encrypt any file on the system using OpenSSL AES-256-CBC.  
Supports absolute file paths (Documents, Desktop, etc.).

### 2. File Decryption
Decrypt previously encrypted `.enc` files securely.

### 3. User Account Locking
Lock a Linux system user account (prevents login).  
Requires root privileges.

### 4. User Account Unlocking
Unlock previously locked accounts.

### 5. Brute-Force Attack Analysis
- Reads `/var/log/auth.log`  
- Detects failed SSH login attempts  
- Extracts and counts attacker IPs  
- Displays top failed attempts  
- Helps analyze live attack patterns

### 6. Automatic IP Blocking
If an IP exceeds the threshold (default: 3 failed attempts), the system:
- Blocks the IP using `iptables`
- Logs the action
- Saves it in `data/blocklist.txt`

### 7. Audit Logging
All actions are saved in `data/audit.log`, including timestamps:
- Encryption/Decryption events  
- IP blocks  
- User lock/unlock  
- Brute-force scans  

---

## PROJECT STRUCTURE

```

OS_security/
│
├── main.sh                   # Main control script
│
├── config/
│   └── settings.conf         # Global configuration and paths
│
├── modules/
│   ├── brute_force_monitor.sh  # Detect & block brute-force attacks
│   ├── ip_block.sh             # Block/unblock IPs via iptables
│   ├── encryption.sh           # AES-256 encryption
│   ├── decryption.sh           # AES-256 decryption
│   ├── user_lock.sh            # Lock a user account
│   ├── user_unlock.sh          # Unlock a user account
│   └── utils.sh                # Logging functions & helpers
│
├── data/
│   ├── audit.log               # Logs of actions performed
│   ├── blocklist.txt           # Blocked IP history
│   └── temp files              # Extracted IP lists, counts, etc.
│
└── README.md

````

---

## HOW TO RUN

### 1. Clone the repository
```bash
git clone https://github.com/mriiidul/OS_security.git
cd OS_security/OS_security
````

### 2. Give execute permission

```bash
chmod +x main.sh
chmod -R +x modules/
```

### 3. Run the system

```bash
sudo ./main.sh
```

*Root privileges are recommended for:*

* Checking /var/log/auth.log
* Blocking attacker IPs
* Locking/unlocking system accounts

---

## BRUTE-FORCE DETECTION WORKFLOW

1. Read system log:

```
/var/log/auth.log
```

2. Extract failed login entries
3. Extract attacker IP addresses using regex
4. Count attempts per IP
5. Sort results (highest first)
6. If attempts ≥ threshold → block IP
7. Log all actions

Example detection output:

```
17 192.168.0.102
4  192.168.0.107
```

Example block event:

```
Blocking IP: 192.168.0.102
```

---

## RUN AS A CRONJOB (Optional)

To auto-scan every minute:

```bash
sudo crontab -e
```

Add:

```
* * * * * /home/mridul/OS_security/OS_security/main.sh --auto
```

---

## REQUIREMENTS

* Ubuntu / Linux system
* Bash shell
* OpenSSL
* iptables
* Root/sudo access

Install dependencies:

```bash
sudo apt update
sudo apt install openssl iptables
```

---

## TEAM WORK USING GITHUB

This project supports group collaboration through:

* Private GitHub repository
* Branching and merging
* Commit tracking
* Team-based development workflow

---

## PURPOSE

This project demonstrates real OS-level security operations using shell scripting:

* System log analysis
* Attack detection
* Firewall automation
* File security
* User management

Perfect for university assignments, security demos, and practical OS labs.

---
