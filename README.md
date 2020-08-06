# CIAB Mesh VPN Internet Overlay

The ***Cloud In A Box (CIAB)*** project introduces what we describes as the 
*CIAB Mesh VPN Internet Overlay Architecture*.

## Goals of the CIAB Mesh VPN Internetworking Overlay Project

The ideal solution to satisfy the goals of this project will include the following
***Key Performance Indicator (KPI)*** success factors:
*
1. Security and Secure communications
2. Open Source
3. Supports use of LXD Containers & VMs and LXD related technologies
4. Easy/simple installation, configuration and expansion
5. Multi-node (re Multi LXD Host/Server) capable, intranet or Internet
6. Multi-Cloud and Hybrid Cloud capable
*

Everything is implemented using Open Source tools and applications:   
*  
- Linux (I use Ubuntu)
- Wireguard
- VxWireguard-Generator
- Free Range Routing (FRR)  
- BGP and BGP-VRFs  
- VXLAN   
- and LXD VMs and Containers  
*  
For complete step-by-step installation/configuration instructions see:

**[The CIAB Mesh VPN Internet Overlay Installation Guide](https://github.com/bmullan/CIAB-Mesh-VPN-Wireguard-FRR-BGP-VXLAN-Internet-Overlay/blob/master/CIAB%20Mesh%20VPN%20Internet%20Overlay%20Installation%20Guide%20%20-%20single-tenant.pdf)**

**[CIAB's Mesh VPN Utility Scripts - used to start/stop/restart etc Wiregard, FRR, BGP](https://github.com/bmullan/CIAB-Mesh-VPN-Wireguard-FRR-BGP-VXLAN-Internet-Overlay/blob/master/ciabvpn-utility-scripts.tar.gz)**

*Utilizing the CIAB Mesh VPN Internet Overlay you can quickly connect LXD VM's and LXD Containers
running in your Single/Multi-Tenant, Multi-Node/Server, Multi-Cloud or Hybrid/Cloud Datacenters.*

All data traffic is highly encrypted by Wireguard.

