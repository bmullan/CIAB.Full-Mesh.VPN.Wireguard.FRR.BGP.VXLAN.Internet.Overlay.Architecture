## Cloud In A Box: Full Mesh VPN Internet Overlay

The ***Cloud In A Box (CIAB)*** project introduces what we describe as the 
***CIAB Full Mesh VPN Internet Overlay Architecture***.

***Note:*** There are 2 Youtube Video's referenced further down.  The first is a 8-10 min Intro and the second actually covers the Installation Guide
step-by-step as I configure all of this on Two different Clouds  and a local VM.   There are only about 14 steps.

---  
### Definitions  

***Full Mesh** means any node can reach any other node directly without going through some central node.*  
***Virtual Private Network (VPN)** means your entire Internet Overlay is fully encrypted end-to-end.*  
***Overlay** Network overlays are a method of using software virtualization to create additional layers 
of network abstraction (or software-based network overlays) that can be run on top of the physical network, 
often providing new applications or enhanced security benefits.*  
***VXLAN** [here is a diagram of the VXLAN Model](https://github.com/bmullan/CIAB.Full-Mesh.VPN.Wireguard.FRR.BGP.VXLAN.Internet.Overlay.Architecture/issues/1)*

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
  
---  
  
For the **Complete Step-by-Step Installation/Configuration Instruction Guide** see:

- **[The CIAB Mesh VPN Internet Overlay Installation Guide](docs/runsheet.md)**

To Download the **CIAB Mesh VPN Utility Scripts** see:

- **[CIAB's Mesh VPN Utility Scripts - used to start/stop/restart etc Wiregard, FRR, BGP](https://github.com/bmullan/CIAB-Mesh-VPN-Wireguard-FRR-BGP-VXLAN-Internet-Overlay/blob/master/ciabvpn-utility-scripts.tar.gz)**

*Utilizing the CIAB Mesh VPN Internet Overlay you can quickly connect LXD VM's and LXD Containers
running in your Single/Multi-Tenant, Multi-Node/Server, Multi-Cloud or Hybrid/Cloud Datacenters.*

All **data traffic is highly encrypted end-to-end** by Wireguard's VPN.

VxLAN supports Layer2/3 with *Layer 3 preventing flooding your Overlay Network* with **Broadcast, Unknown and Multicast (BUM) traffic**.

---  

On Youtube are two Video's to help you understand and to install & configure the CIAB Full-Mesh VPN Internet Overlay Architecture using
our Installation Guide see:

**Video #1**  

- **[Introduction to CIAB's Full-Mesh VPN Internet Overlay](https://www.youtube.com/watch?v=XvjMMuIItF4&t=3s)** - approx 10 minutes long  

**Video #2**  

> ***Note:** you can download the Installation Guide PDF (see above) if you want to follow it while watching Video #2*

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

---

**NOTE:**  There is no practical limit to the number of Nodes/Servers/VMs you can add to the Mesh-VPN except the *Underlay* **Physical
network** that the *Overlay* is built upon.   

Given that a single Node/Server can support possibly hundreds of LXD containers and using this Overlay the Containers on any 1 Server
can interact/access Containers on any other Server anywhere in the Mesh directly and securely... well things can become interesting.
