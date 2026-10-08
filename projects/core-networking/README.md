# 📡 Core Networking & Hybrid Topology Architecture

## 📌 Project Overview
This module acts as a dedicated archive for my standalone network infrastructure labs, physical routing configurations, and local virtualization topologies. 

The primary objective is to simulate enterprise-grade hybrid environments, testing the data transit link layers between traditional hardware appliances, software-defined routes, and virtualized computing blocks.

---

## 🛠️ Implemented Technologies & Technical Stack
*   **Virtualization Hypervisors:** KVM / QEMU kernel-based architecture, virtual switch integration, and local bridge interface provisioning.
*   **Simulation Engines:** GNS3 / Cisco Packet Tracer mapping for complex topologies.
*   **Core Routing Protocols:** WAN routing strategies, static path isolation, and subnetting structures (IPv4 VLSM).
*   **Traffic Controllers:** Access Control Lists (ACLs) and network interface filtering paradigms.

---

## 🗺️ Tested Laboratory Topologies

### 🎛️ 1. Multi-Zone Local Routing & VLAN Segmentation
*   **Objective:** Construct a three-tier network architecture separating corporate traffic, guest access links, and administrative control paths.
*   **Implementation:** Configured dynamic inter-VLAN routing patterns on virtualized switchboards, ensuring isolated broadcast domains and dropping unauthenticated packets across boundaries.

### 🐧 2. Kernel-Based Virtualization & Network Bridging (KVM)
*   **Objective:** Deploy and connect localized Linux guest servers using high-performance host bridge components.
*   **Implementation:** Configured native host bridges (`br0`) inside a local Linux machine to pass internal virtual machine network cards straight into the physical gateway layer without NAT interference.

### 🛡️ 3. Default Gateway Failover & Latency Audits
*   **Objective:** Simulate a wide-area network (WAN) link failure and analyze alternative route convergence tracking times.
*   **Implementation:** Intentionally severed interface endpoints inside simulation topologies, verified automated local route table adaptation sequences, and audited latency recovery states via automated test tools.

---

## 🚀 Repository Directory Checklist
* [x] **Topological Maps:** Comprehensive layout diagrams capturing IP assignments and node boundaries.
* [ ] **Device Configurations:** Raw text configuration dumps from routers and switch interfaces.
* [ ] **Audit Validation Run:** Local connection diagnostics and performance capture sheets.
