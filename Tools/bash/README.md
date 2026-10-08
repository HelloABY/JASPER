# 🐚 Bash Scripting & Linux System Utilities

## 📌 General Purpose
This directory houses production-ready, POSIX-compliant Shell and Bash utilities engineered to handle system post-deployment initialization, automated network diagnostics, and environment security hardening. 

Every script inside this module follows defensive engineering principles—incorporating strict fail-fast error traps (`set -euo pipefail`), performing structural pre-flight validation checks before applying system configurations, and maintaining clean audit log structures for operational visibility.

---

## 🛠️ Tools Architecture & Operational Aspects
To showcase a complete mid-tier systems administrator mindset, the tools inside this folder cover the core operational layers of a Linux compute node:

1.  **System Security & Hardening Architecture ([`server_hardening.sh`](./server_hardening.sh))**
    *   *Aspect Covered:* Automation of operating system baseline updates, network perimeter security mapping via Uncomplicated Firewall (UFW) rules, and high-level remote access protocol restrictions (disabling raw SSH root logins and forcing cryptographic key-only authentication models).
2.  **Network Diagnosis & Latency Inspection ([`local_network_audit.sh`](./local_network_audit.sh))**
    *   *Aspect Covered:* Real-time kernel analysis that maps active network interface layers, parses internal routing tables, extracts default gateway vectors, and executes short-packet diagnostic handshakes to test infrastructure integrity boundaries.

---

## 🚀 Execution Baseline
All scripts in this workspace require root execution privileges and explicit local permissions before deployment:

```bash
# Grant executable rights
chmod +x <script_name>.sh

# Execute with administrative privileges
sudo ./<script_name>.sh
```
