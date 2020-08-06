# CIAB Full Mesh VPN Internet Overlay

The ***Cloud In A Box (CIAB)*** project introduces what we describe as the 
***CIAB Full Mesh VPN Internet Overlay Architecture***.

---  
### Definitions  

***Full Mesh** means any node can reach any other node directly without going through some central node.*  
***Virtual Private Network (VPN)** means your entire Internet Overlay is fully encrypted end-to-end.*  
***Overlay** Network overlays are a method of using software virtualization to create additional layers 
of network abstraction (or software-based network overlays) that can be run on top of the physical network, 
often providing new applications or enhanced security benefits.*

---

## Goals of the CIAB Mesh VPN Internet Overlay Project

The ideal solution to satisfy the goals of this project will include the following
***Key Performance Indicator (KPI)*** success factors:
  
> **1. Security and Secure communications  
> 2. Open Source  
> 3. Supports use of LXD Containers & VMs and LXD related technologies  
> 4. Easy/simple installation, configuration and expansion  
> 5. Multi-node (re Multi LXD Host/Server) capable, intranet or Internet  
> 6. Multi-Cloud and Hybrid Cloud capable**  

---

The CIAB Full Mesh VPN Inteernet Overlay Architecture is completly implemented using  
Open Source tools and applications:   
 
- **[Ubuntu Linux](https://ubuntu.com/server/docs)**
- **[Wireguard VPN](https://www.wireguard.com/)**
- **[VxWireguard-Generator](https://github.com/m13253/VxWireguard-Generator)**
- **[Free Range Routing - FRR](https://frrouting.org/)**
- **[FRR's BGP and BGP-VRF protocols](http://docs.frrouting.org/en/latest/bgp.html)**  
- **[Virtual eXtended LAN - VXLAN](https://user-images.githubusercontent.com/1682855/89578990-02194980-d801-11ea-8f39-62c74b625732.png)**   
- **[LXD VMs and Containers](https://linuxcontainers.org/lxd/docs/master/)**  
  
For complete step-by-step installation/configuration instructions see:

- **[The CIAB Mesh VPN Internet Overlay Installation Guide](https://github.com/bmullan/CIAB-Mesh-VPN-Wireguard-FRR-BGP-VXLAN-Internet-Overlay/blob/master/CIAB%20Mesh%20VPN%20Internet%20Overlay%20Installation%20Guide%20%20-%20single-tenant.pdf)**

- **[CIAB's Mesh VPN Utility Scripts - used to start/stop/restart etc Wiregard, FRR, BGP](https://github.com/bmullan/CIAB-Mesh-VPN-Wireguard-FRR-BGP-VXLAN-Internet-Overlay/blob/master/ciabvpn-utility-scripts.tar.gz)**

*Utilizing the CIAB Mesh VPN Internet Overlay you can quickly connect LXD VM's and LXD Containers
running in your Single/Multi-Tenant, Multi-Node/Server, Multi-Cloud or Hybrid/Cloud Datacenters.*

All **data traffic is highly encrypted end-to-end** by Wireguard's VPN.

VxLAN supports Layer2/3 with *Layer 3 preventing flooding your Overlay Network* with **Broadcast, Unknown and Multicast (BUM) traffic**.

On Youtube are two Video's to help you understand and to install & configure the CIAB Full-Mesh VPN Internet Overlay Architecture using
our Installation Guide see:

**Video #1**  

- **[Introduction to CIAB's Full-Mesh VPN Internet Overlay](https://www.youtube.com/watch?v=XvjMMuIItF4&t=3s)** - approx 10 minutes long  

**Video #2**  

- **[CIAB Full-Mesh VPN Internet Overlay Installation Guide - Step-by-Step](https://www.youtube.com/watch?v=HVJlIE2TUpc)**  - approx 1 hr long  

*Video #2 will implement a 3 Node Full-Mesh VPN Internet Overlay using 3 Servers*:

- **1 - a Digital Ocean Cloud server located in the U.S.**  
- **1 - a Hetzner Cloud server located in Germany**  
- **1 - an LXD VM on one of my local servers**  *traffic to/from this VM is limited by my local Wifi which is 200Mbps down and 20Mbps up.*

At the end of Video #2 you will see Ping tests showing connectivity to/from ANY Node to/from ANY other Node's LXD Containers which are
on ***private*** 10.x.x.x networks within each Node.  

The 10.x.x.x network range is **not** Routeable over the Internet thus proving the success of the 
***CIAB Full-Mesh VPN Internet Overlay*** in providing that universal inter-connectivity.

All Servers and LXD VM and LXD containers are running Ubuntu 20.04 LTS.

**NOTE:**  There is no practically no limit to the number of Nodes/Servers/VMs you can add to the Mesh-VPN.   





