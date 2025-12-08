# **OS Security & Protection System**

A modular, Bash-based security suite designed to enhance Linux system protection through **AES-256 encryption**, **user account control**, and **intrusion detection**.
This project was built as part of the *Operating Systems Lab* course.

---

## 🔐 **Project Overview**

The **OS Security & Protection System** provides essential OS-level protection features without third-party dependencies—only pure Linux commands and Bash scripting.
It demonstrates practical concepts like:

* Cryptographic file protection
* Authentication hardening
* User account management
* System log monitoring

This project is lightweight, educational, and fully CLI-based.

---

## ⚙️ **Features**

### 🔒 File Security

* AES-256-CBC encryption using OpenSSL
* PBKDF2 key strengthening
* Secure file deletion (optional, using `shred`)
* Safe file decryption with password validation

### 👥 User Account Protection

* Lock system accounts (`passwd -l`)
* Unlock system accounts (`passwd -u`)
* Prevent unauthorized system access

### 🛡 Intrusion Detection

* Scans `/var/log/auth.log` or `/var/log/secure`
* Detects brute-force SSH login attempts
* Shows top attacker IP addresses
* Lists recent failed login attempts

### 📁 Logging

* All actions stored in `data/audit.log`
* Useful for tracking usage and security events

### 🧩 Modular Architecture

* Separate scripts for each feature
* Easy to maintain and upgrade

### 🖥 Menu-Driven Interface

* Centralized control via `main.sh`
* Simple, clean, user-friendly CLI

---

## 📂 **Project Structure**

```
OS_security/
│── main.sh
│── config/
│   └── settings.conf
│── lib/
│   └── utils.sh
│── modules/
│   ├── encryption.sh
│   ├── decryption.sh
│   ├── user_lock.sh
│   ├── user_unlock.sh
│   └── brute_force_monitor.sh
│── data/
│   ├── audit.log
│   ├── failed_attempts.log
│   └── users.db
└── README.md
```

---

## 🚀 **How to Run**

### 1️⃣ Make scripts executable:

```bash
chmod +x main.sh
chmod -R +x modules
chmod -R +x lib
```

### 2️⃣ Install OpenSSL (if needed):

```bash
sudo apt install openssl -y
```

### 3️⃣ Run the program:

Normal mode:

```bash
./main.sh
```

Root mode (recommended for account control):

```bash
sudo ./main.sh
```

---

## 🧪 **Tested On**

* Ubuntu 20.04 / 22.04
* Debian 11
* Fedora 38
* WSL2 (Windows Subsystem for Linux)

---

## 🤝 **Collaboration**

This project is maintained by a team using **Git** and **GitHub** for version control.

### GitHub repository:

🔒 Private Repo
[https://github.com/mriiidul/OS_security](https://github.com/mriiidul/OS_security)

Contributions follow Git workflow:

```bash
git add .
git commit -m "your message"
git push
```

---

## 🔮 **Future Enhancements**

* Add user-level authentication with a script-managed login system
* Implement IP auto-blocking using UFW or iptables
* Build a GUI using Zenity
* Add RSA-based file encryption option
* Develop a live monitoring dashboard

---

## 📜 **License**

This project is created for educational purposes under the Operating Systems Lab course.
Feel free to reference, fork (if repo becomes public), or extend with proper credit.
