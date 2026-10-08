# ⚡ PowerShell Cloud & Systems Automation Modules

## 📌 General Purpose
This directory houses Microsoft PowerShell (`.ps1`) modules designed to handle automated resource governance, cost optimization, and systems management across enterprise environments and Microsoft Azure cloud tenants. 

The tools here focus on administrative efficiency—querying objects dynamically, verifying authorization scopes, and automating housekeeping routines to minimize operational waste and billing overhead.

---

## 🛠️ Tools Architecture & Aspects Covered
To showcase a strong cloud administration and cost-management mindset, the tools inside this folder focus on cloud tenant hygiene:

1.  **Cloud Resource & Cost Governance ([`cleanup_orphaned_disks.ps1`](./cleanup_orphaned_disks.ps1))**
    *   *Aspect Covered:* Connects securely to an Azure subscription, scans resource groups for unattached (orphaned) Managed Virtual Hard Disks (VHDs) that are silently draining the budget, logs their details, and safely purges them to optimize infrastructure spending.

---

## 🚀 Execution Baseline
All scripts within this folder interface with local windows modules or remote Azure cloud instances. Ensure your processing scopes are appropriately set before running tasks:

```powershell
# Set safe script execution privileges for the active session
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

# Initialize script modules
.\<script_name>.ps1
```
