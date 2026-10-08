# ☁️ Azure Cloud Infrastructure Landing Zones & Governance

## 📌 Project Overview
This module serves as a dedicated catalog for my automated public cloud resource deployments, secure tenant landing zones, and cost-optimized virtual network infrastructures. 

The primary objective is to engineer an enterprise-grade cloud footprint from scratch inside Microsoft Azure—incorporating strict identity boundaries, zero-trust network segregation patterns, and automated monitoring systems to drop security tracking leakages.

---

## 🛠️ Implemented Technologies & Cloud Stack
*   **Cloud Platform:** Microsoft Azure (Tenant Management & Subscription Scopes).
*   **Identity Controls:** Azure Active Directory / Entra ID, Role-Based Access Control (RBAC), and Custom Policy Configurations.
*   **Networking Layer:** Virtual Networks (VNets), Subnet Segregations, VNet Peering Hubs, and User-Defined Route Tables (UDR).
*   **Perimeter Firewalls:** Network Security Groups (NSGs), Application Security Groups (ASGs), and Private Service Endpoints.
*   **Automation Frameworks:** Azure Resource Manager (ARM) Declarative JSON Schemas and Bicep Infrastructure Templates.

---

## 🗺️ Architectural Cloud Deployments

### 👤 1. Hardened Identity Architecture & Granular Access Control
*   **Objective:** Construct a secure enterprise tenant environment that prevents unauthenticated resource provisioning.
*   **Implementation:** Configured hierarchical Azure RBAC permissions passing clean boundaries from Management Groups down to isolated Resource Groups. Built custom policy engines that restrict virtual machine provisioning to highly cost-optimized compute families.

### 📡 2. Hub-and-Spoke Virtual Networking & Traffic Interception
*   **Objective:** Segregate core application databases from public web servers using a centralized routing perimeter.
*   **Implementation:** Deployed a Hub VNet housing a simulated virtual security appliance, paired with two separate Spoke VNets via non-transitive Peering. Configured User-Defined Routes (UDRs) inside custom Route Tables to forcefully bend all cross-VNet data paths straight through the central security appliance for absolute inspection.

### 💰 3. Automated Storage Security & Cost Management Systems
*   **Objective:** Secure high-capacity blob storage accounts from open web scans while automating cost reduction.
*   **Implementation:** Provisioned cloud storage instances locked behind private virtual networks, disabling public endpoints entirely. Implemented automated Lifecycle Management rules that dynamically transition stale logs and file shares down into Cold and Archive replication tiers based on time thresholds to minimize monthly billing fees.

---

## 🚀 Repository Directory Checklist
* [x] **Infrastructure Blueprints:** Comprehensive mapping of VNet address allocations and resource group divisions.
* [ ] **Deployment Frameworks:** Reusable Bicep/ARM configuration schemas for template instantiation.
* [ ] **Audit Trail Metrics:** Local PowerShell monitoring sheets tracking resource utilization.
