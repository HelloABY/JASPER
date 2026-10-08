#!/bin/bash
# ==============================================================================
# SCRIPT:      local_network_audit.sh
# DIRECTORY:   JASPER/Tools/bash/
# DESCRIPTION: Inspects active network interface layers, maps kernel routing 
#              tables, and runs diagnostic connectivity handshakes.
# ==============================================================================

# Exit if a command fails (-e) or an unassigned variable is called (-u)
set -euo pipefail

echo "======================================================================"
echo "📡 J.A.S.P.E.R. LOCAL NETWORK DIAGNOSTIC PROTOCOL"
echo "======================================================================"

# Ensure baseline networking diagnostics utilities exist on the system
for binary in ip ping awk grep; do
    if ! command -v "$binary" &> /dev/null; then
        echo "[ERROR] Mandatory environment utility '$binary' is missing. Aborting." >&2
        exit 1
    fi
done

echo -e "\n[*] 1. Analyzing Active Network Link States..."
ip -br link show

echo -e "\n[*] 2. Parsing Active Kernel Routing Tables..."
ip route show

echo -e "\n[*] 3. Evaluating Default Gateway Layer & Latency..."
# Extract the active default gateway IP vector from routing logs
GATEWAY=$(ip route | grep default | awk '{print $3}' | head -n 1)

if [ -z "$GATEWAY" ]; then
    echo "[!] WARNING: No default gateway detected. Local interface is isolated."
else
    echo "[+] Active Default Gateway discovered at target node: $GATEWAY"
    echo "[*] Triggering short-packet ICMP diagnostics (3 packets)..."
    
    # Run ping command bound to a 2-second timeout step
    if ping -c 3 -W 2 "$GATEWAY"; then
        echo "[SUCCESS] Gateway perimeter connectivity checks completed cleanly."
    else
        echo "[ERROR] Packet drop, high latency, or timeout encountered during transit." >&2
        exit 1
    fi
fi

echo -e "\n======================================================================"
echo "Local Network Diagnostics Pipeline Concluded Cleanly. ✅"
echo "======================================================================"
