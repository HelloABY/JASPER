# ☁️ Microsoft Azure Administrator (AZ-104) Core Matrix

This directory tracks my hands-on labs, configuration deep-dives, and technical progression blocks as I prepare to master the Microsoft Azure Administrator curriculum. 

Following my strict personal architecture baseline, my focus is divided into the core enterprise pillars of cloud infrastructure, with absolute priority placed on virtual networking layouts, identity isolation, and secure resource boundaries.

---

## 🛠️ Infrastructure Operational Pillars & Lab Status

### 🛡️ 1. Identity, Governance & Compliance
* [x] **Azure AD / Entra ID Architecture:** Configuring multi-tenant identity models, custom user attributes, and group privilege inheritance schemes.
* [x] **Role-Based Access Control (RBAC):** Engineering custom security roles, applying scope boundaries (Management Groups down to Resources), and auditing access paths.
* [x] **Governance & Compliance Policies:** Deploying Azure Policy constraints and resource tags to enforce corporate deployment standards and prevent unauthorized resource creations.

### 📦 2. Hybrid Storage Infrastructures
* [x] **Storage Lifecycle Rules:** Configuring hot, cool, cold, and archive storage blob replication profiles based on automated consumption trends.
* [x] **Network Security Boundaries:** Securing storage accounts behind private endpoints, disabling public internet paths, and managing secure Shared Access Signatures (SAS) tokens.
* [x] **Azure Files & Sync:** Provisioning high-availability cloud file shares and managing local file synchronization runtimes across hybrid nodes.

### ⚙️ 3. Azure Compute & Elastic Deployments
* [x] **Virtual Machine Staging:** Authoring automated ARM / Bicep deployment templates to build identical, hardened virtual instances across resource blocks.
* [x] **Availability Sets & Scale Groups:** Configuring fault domains, update domains, and automatic horizontal scaling metrics to preserve system performance metrics.
* [x] **Container Architecture:** Building microservice environments via Azure Container Instances (ACI) and App Services to isolate lightweight workloads.

### 📡 4. Advanced Virtual Networking (Primary Deep-Dive Focus)
* [x] **VNet Architecture & Peering:** Implementing complex IP subnetting logic across isolated virtual networks and troubleshooting transitivity peering gaps.
* [x] **Traffic Engineering (NSGs & ASGs):** Structuring Network Security Group inbound/outbound rulesets to isolate production database nodes from web layers.
* [x] **Azure Route Tables:** Creating User-Defined Routes (UDRs) to forcefully pass traffic paths through custom network firewall appliances.
* [x] **Hybrid Connectivity Engines:** Building secure, cross-boundary site-to-site VPN tunnels and understanding Azure ExpressRoute failover behaviors.

### 📊 5. Infrastructure Monitoring, Auditing & Backups
* [x] **Log Analytics Environments:** Running Kusto Query Language (KQL) scripts inside Azure Monitor to isolate tenant errors and security anomalies.
* [x] **Alert Remediation Metrics:** Configuring metrics alert logic to trigger automated system webhooks when resource consumption thresholds leak.
* [x] **Azure Site Recovery (ASR) & Backup:** Planning zero-downtime replication boundaries and testing operational server recovery backup snapshots.

---

## 🚀 Active Resources & Lab Environment
*   **Primary Sandbox:** Live Azure Subscription (Utilizing free tiers, promotional credits, and isolated lab environments).
*   **Simulation Engines:** GNS3 / Cisco Packet Tracer mapping for local hybrid networking integrations.
