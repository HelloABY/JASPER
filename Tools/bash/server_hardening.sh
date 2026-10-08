#!/bin/bash
# ==============================================================================
# SCRIPT:      server_hardening.sh
# DIRECTORY:   JASPER/Tools/bash/
# DESCRIPTION: Automated baseline security configuration for fresh Linux nodes.
#              Includes strict error handling, auditing logs, and SSH hardening.
# ==============================================================================

# Exit immediately if any command fails (-e) and treat unset variables as an error (-u)
set -euo pipefail

# 🛠️ Define Configuration Constants
LOG_FILE="/var/log/jasper_hardening.log"
SSH_CONFIG="/etc/ssh/sshd_config"

# 📝 Logging Helper Function
log_message() {
    local TYPE="$1"
    local MSG="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$TYPE] - $MSG" | sudo tee -a "$LOG_FILE"
}

# Ensure script is being run with administrative privileges
if [ "$EUID" -ne 0 ]; then
    echo "Error: This hardening sequence must be executed as root (sudo)." >&2
    exit 1
fi

log_message "INFO" "Initializing J.A.S.P.E.R. Industrial Hardening Protocol..."

# 🔄 Step 1: System Baseline OS Maintenance
log_message "INFO" "Updating package repository indexes and upgrading core binaries..."
apt-get update -y && apt-get upgrade -y

# 🚧 Step 2: Network Perimeter Isolation (UFW Firewall)
log_message "INFO" "Configuring Network Security Perimeter (UFW)..."
ufw default deny incoming
ufw default allow outgoing

# Explicitly permit essential traffic lanes
ufw allow 22/tcp  # Secure Shell (SSH)
ufw allow 80/tcp  # Standard Web Traffic (HTTP)
ufw allow 443/tcp # Encrypted Transport Layer Security (HTTPS)

# Force-enable firewall without interactive interruption
echo "y" | ufw enable
log_message "SUCCESS" "Perimeter firewall rules applied and verified active."

# 🔑 Step 3: Hardening Remote Access Protocols (SSH Security)
log_message "INFO" "Modifying SSH configuration boundaries..."

if [ -f "$SSH_CONFIG" ]; then
    # Create an automated backup of the raw file before editing (Best Practice!)
    cp "$SSH_CONFIG" "${SSH_CONFIG}.bak"
    
    # Enforce elite security parameters using in-place text streams
    sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' "$SSH_CONFIG"
    sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' "$SSH_CONFIG" # Forces SSH Key login only!
    sed -i 's/^#\?MaxAuthTries.*/MaxAuthTries 3/' "$SSH_CONFIG"                        # Restricts brute force
    
    # Verify the syntax configuration is valid before restarting the daemon
    if sshd -t; then
        systemctl restart sshd
        log_message "SUCCESS" "SSH daemon configurations hardened and reloaded cleanly."
    else
        log_message "ERROR" "SSH configuration syntax validation failed. Rolling back changes."
        mv "${SSH_CONFIG}.bak" "$SSH_CONFIG"
        exit 1
    fi
else
    log_message "WARNING" "Target SSH configuration path not found. Step bypassed."
fi

log_message "SUCCESS" "Hardening sequence executed fully. Audit logs generated at $LOG_FILE."
