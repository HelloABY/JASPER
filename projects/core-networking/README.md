# 📡 Lab 01: Multi-Zone VLAN Segmentation & ACL Hardening (GNS3)

## 📌 Project Overview
This project documents a manual, hands-on network isolation lab built inside GNS3 using a Cisco 7200 routing node. The objective was to configure a secure local topology that completely segments guest traffic from the internal secure data sector while maintaining strict access control boundaries.

---

## 🗺️ Physical & Logical Topology Details
*   **Edge Router:** `JASPER-EDGE-R01`
*   **Secure Subnet (VLAN 10):** `10.0.10.0/24` (Gateway: `10.0.10.1`)
*   **Guest Subnet (VLAN 20):** `172.16.20.0/24` (Gateway: `172.16.20.1`)
*   **WAN Link Layer:** DHCP boundary via physical interface bridge `GigabitEthernet0/0`

---

## 🛠️ Step-by-Step Configuration Notebook

Instead of just automated scripts, this topology was initialized manually to test link-layer behaviors. 

### 1. Initializing Sub-Interfaces & Dot1Q Encapsulation
To pass multiple isolated broadcast domains through a single trunk link to our switch environment, sub-interfaces were initialized on the core interface:

```text
Router# configure terminal
Router(config)# interface GigabitEthernet0/1.10
Router(config-subif)# description Secure Internal Operations Sector
Router(config-subif)# encapsulation dot1Q 10
Router(config-subif)# ip address 10.0.10.1 255.255.255.0
```

### 2. Hardening the Network Perimeter (Extended ACLs)
An extended Access Control List (`SECURE_PERIMETER_ACL`) was engineered to block the Guest network (`172.16.20.0/24`) from scanning or communicating with the secure internal subnet, while still allowing them to route out to the internet for HTTP/HTTPS traffic:

```text
Router(config)# ip access-list extended SECURE_PERIMETER_ACL
Router(config-ext-nacl)# deny ip 172.16.20.0 0.0.0.255 10.0.10.0 0.0.0.255
Router(config-ext-nacl)# permit ip any any
Router(config)# interface GigabitEthernet0/1.20
Router(config-subif)# ip access-group SECURE_PERIMETER_ACL in
```

---

## 🧠 Real Lab Troubleshooting Log (My Philosophy in Action)

**The Issue Encountered:** 
During initial link-layer validation testing, host machines inside Guest VLAN 20 were completely unable to ping the external default gateway or fetch public web traffic, even though local routing tables were active.

**The Diagnostic Process:** 
I ran an interface check (`show ip interface brief`) and found that while sub-interface `GigabitEthernet0/1.20` was up, the physical carrier interface `GigabitEthernet0/1` was in an unassigned administrative state. 

**The Resolution:** 
In Cisco systems, sub-interfaces cannot pass transit frames if the primary interface is disabled. Escallated to the physical carrier node and forcefully toggled the link state:
```text
Router(config)# interface GigabitEthernet0/1
Router(config-if)# no shutdown
```
Immediately following the link status change, spanning-tree converged and ICMP packet transport was successfully restored across all interface boundaries.

---

## 📊 Live Verification Logs (Verification Run)

This is the actual operational console log captured from `JASPER-EDGE-R01` confirming the active interface properties:

```text
JASPER-EDGE-R01# show ip interface brief
Interface                  IP-Address      OK? Method Status                Protocol
GigabitEthernet0/0         192.168.1.112   YES DHCP   up                    up      
GigabitEthernet0/1         unassigned      YES unset  up                    up      
GigabitEthernet0/1.10      10.0.10.1       YES manual up                    up      
GigabitEthernet0/1.20      172.16.20.1     YES manual up                    up      
```
