# CIAB Mesh VPN Internetwork Overlay Architecture

Multi-Node, Multi-Cloud/Hybrid Systems

Using BGP, VxLAN, BGP VRF and LXD to implement LXD VM & Container
Multi-Node, Multi-Cloud/Hybrid Systems

includes protocol daemons for BGP, OSPF, RIP etc.
The Cloud in a Box (CIAB) Mesh VPN is a software-defined wide-area network that is
abstracted from hardware, creating a virtualized network overlay.

## CIAB Mesh VPN Internet Overlay Architecture

The CIAB Mesh VPN Internet Overlay Architecture is implemented using several open source
linux networking tools/apps, Routing and protocol capabilities including:
[Free Range Routing (FRR)](https://frrouting.org/#participate) - FRR is an IP routing protocol suite for Linux and Unix platforms which
includes protocol daemons for BGP, OSPF, RIP etc.

Virtual eXtensible LAN (VxLAN) – [an overview of VxLAN and Linux by Vincent Bernat](https://vincent.bernat.ch/en/blog/2017-vxlan-linux)

![Figure 1-1 VXLAN network model][fig_1_1]

A VxLAN network is a virtual Layer 2 network constructed on a Layer 3 network to enable
communication of hosts at Layer 3

### BGP Route Reflectors

[Vincent Bernat provides an excellent general overview](https://vincent.bernat.ch/en/blog/2017-vxlan-linux).

![Figure 1-2 Full Mesh BGP Network not using Route Reflectors][fig_1_2]

[BGP Route reflectors (RR)](https://www.fir3net.com/Networking/Protocols/what-is-a-bgp-route-reflector.html)
are one method to get rid of the full mesh of iBGP Peers in your network. While still providing Routing information to all nodes about all nodes.

![Figure 1-3 Full Mesh BGP Network when using Route Reflectors][fig_1_3]

- [WireGuard](https://www.wireguard.com/) – WireGuard VPN is now built into the Linux Kernel itself. WireGuard is a fast and
  modern VPN that utilizes state-of-the-art cryptography.
- [LXD](https://linuxcontainers.org/lxd/introduction/) – LXD is a System VM and Container Hypervisor
- [VxWireGuard-Generator](https://github.com/m13253/VxWireguard-Generator) - Utility to generate V x LAN over Wireguard mesh SD-WAN
  configuration

### VxWireGuard Background

[VxWireguard-Generator (`vwgen`)](https://github.com/m13253/VxWireguard-Generator) has three layers of IP addresses that it adds to every CIAB
Network Node’s Wireguard config file (re //etc/wireguard/ciabmesh.net):
The “public ip” address -
They are the your Node/Server/Host’s real Public IP Addresses.
Wireguard uses these addresses to establish VPN Tunnels between Nodes.
The VxLAN Virtual Tunnel End Point (VTEP) address -
They are allocated randomly from 169.254.0.0/16 and IPv6 link-local address space, used to
build the VxLAN network overlay.
The IP addresses used by Wireguard: -
They are allocated from pool-ipv4 and pool-ipv6 you specify during configuration.
Since all nodes are then connected to one "virtual" LAN, preferably you may want these addresses to
reside in one single subnet..
If you are not satisfied with the automatic allocation, for IPv4, you can edit the address manually; for
IPv6, you can add more than one address and set one of them as Primary.

## Goals of the CIAB Mesh VPN Internetworking Overlay Project

The ideal solution to satisfy the goals of this project will include my identified Key Performance
Indicator (KPI) success factors:

1. Security and Secure communications
1. Open Source
1. Supports use of LXD Containers & VMs and LXD related technologies
1. Easy/simple installation, configuration and expansion
1. Multi-node (re Multi LXD Host/Server) capable, intranet or Internet
1. Multi-Cloud and Hybrid Cloud capable

## Installation Guide

### Assumptions

1. Installation is being done on either Ubuntu 18.04 or Ubuntu 20.04 Desktop or Server systems.
   By “system” we mean a some PC/Laptop/Server, Virtual Machines or a Cloud Instances.
   Any or all of which can be part of your CIAB Mesh VPN Overlay Network.
1. Make sure LXD is installed initalized on all Nodes.
1. Steps 5, 6, 7, 8, 9, 10, 11
   need only be performed on one node (you choose) to perform configurations that will be used
   later to configure all nodes.
1. Steps 1, 2, 3, 4, 12, 13, 14, 15
   must be performed on all Nodes/Hosts/ Servers/V M s and configuration files for FRR’s BGP
   (`/etc/frr/bgpd.conf`) edited for appropriate IP addresses in the template supplied in Appendix 1.
1. This Guide Installation does not cover multi-tenant configuration although I have done this
   using additional configuration steps contained in a separate document.

### Step 1

Create an initial Ubuntu 18.04 or Ubuntu 20.04 Node... re a Server/VM or Cloud-Instance which you
intend to become the Nodes in your Mesh VPN Overlay.

### Step 2

Install Free Range Routing (FRR) on each of your Nodes:

    sudo apt install frr -y

Install Wireguard and Wireguard-tools on each of your Nodes:

    sudo apt install wireguard wireguard-tools -y

### Step 3

Edit the FRR daemons Config File on each of your Nodes (use Nano, Vi or whatever text editor):

    sudo nano /etc/frr/daemons

Change :

    bgpd=no

to:

    bgpd=yes

Then save the file with the changes made in Step 3.

### Step 4

Copy (scp) all of the CIAB Mesh VPN Utility Bash scripts to each Node into a directory where you
can execute them and make all of the CIAB Mesh VPN Utility Bash scripts executable.

#### Scripts and their purpose

- `wg-meshup.sh`: Start Wireguard on a Node
- `wg-meshdown.sh`: Shutdown Wireguard on a Node
- `frr-start.sh`: Start FRR on a Node NOTE: Wireguard must be UP on a Node before Starting FRR
- `frr-restart.sh`: Stop then Start FRR on a Node
- `frr-status.sh`: Show FRR Status on a Node
- `frr-stop.sh`: Stop FRR on a Node
- `bgp-start.sh`: Start FRR’s BGP on a Node NOTE: you must start FRR before executing this script
- `bgp-restart.sh`: Stop/Start FRR’s BGP on a Node NOTE: you must start FRR before executing this script
- `bgp-stop.sh`: Stop FRR’s BGP on a Node
- `generate-ipv6-address`: Used by wg-meshup.sh to assign a unique IPv6 address to that node’s Wireguard Interface

given prefix and either a given MAC-48 address (an
Ethernet hardware address) or a randomly drawn host
number.

### Step 5

Install/configure VxWireguard-Generator.
VxWireguard-Generator is a tool which will be used to first generate a Master WireGuard Mesh
Config file.
After the Master Config file has been built we will use the VxWireguard-Generator again to extract
each individual Node’s Wireguard/VxLAN ciabmesh.conf config file.
Log into the Node using ssh or however you do it.
Make sure UNZIP is installed:

    $ sudo apt install unzip -y

Use “wget” to retrieve the VxWireguard-Generator .ZIP file from github (install wget if its not
already).

    $ wget https://github.com/m13253/VxWireguard-Generator/archive/master.zip

Unzip the VxWireguard-Generator

    $ unzip ./master.zip

Change into the unzipped Directory that was created:

    $ cd ./VxWireguard-Generator-master

Install pre-requisites for VxWireguard-Generator.
Install python3-pip:

    $ sudo apt install python3-pip -y

Install VxWirguard-Generator misc files

    $ sudo pip3 install -r requirements.txt
    $ python3 setup.py build
    $ sudo python3 setup.py install --force

### Step 6

Create a Master config file for our CIAB Mesh VPN using [VxWireguard-Generator](https://github.com/m13253/VxWireguard-Generator)

First, create a work directory (let’s call it “ciabvpn”):

    $ mkdir ciabvpn

change into that work directory

    $ cd ./ciabvpn

NOTE: VxWireguard-Generator’s main cli tool is `vwgen`.
To view a `vwgen` help page:

    $ vwgen --help

    Usage vwgen \<sub-commands\> [\<args\>]

    Available sub-commands

    show: Shows the current configuration of the mesh network
    showconf: Generate a configuration file for a given node
    add: Add new nodes to the mesh network
    set: Change the configuration of nodes
    del: Delete nodes from the mesh network
    blacklist: Manage peering blacklist between specified nodes
    zone: Generate BIND-style DNS zone records
    genkey: Generates a new private key and writes it to stdout
    genpsk: Generates a new preshared key and writes it to stdout
    pubkey: Reads a private key from stdin and writes a public key to stdout

You may pass `--help` to any of these sub-commands to view usage.

Start to build the Master VxWireguard-Configuration file (we’ll call ours ciabmesh):

    $ vwgen add ciabmesh

This will create a file a Master config file called `ciabmesh.conf`
Set the IPv4 and IPv6 Address Pool for our CIAB Mesh Internet Overlay.

The following will cause VxWireguard-Generator to utilize IP addresses from these IPv4 and IPv6
address Pools for the configuration of your CIAB Mesh Internetwork.

    $ vwgen set ciabmesh pool-ipv4 172.20.10.0/24 pool-ipv6 2001:db8:42::/64

### Step 7

Decide now if you want to create an exact number of Node Config files or if you want to generate more
(many) than you need today.
Then execute the next step.

**Example:**

Say you only want to create configs for our demo’s 3 nodes

    $ vwgen add ciabmesh node1 node2 node3

The above command will inject modifications into our Master `ciabmesh.conf` file with separate
Sections for each Node (ie `node1`, `node2` etc).

Configuration Hint:

If you want to create many Node configs using a `root` name part and a
sequential Node number here is an example of how to do that:
Say you want to create a Master config file that has 50 Node configs. The name `root` is to be
`mycn` and we want 50 of them:

    $ vwgen add ciabmesh \$(seq -f 'mycn%.f' 50)

This would create a Master config file with 50 Node Configs each named:
`mycn01`, `mycn02`, ... `mycn49`, `mycn50`. Each with its VxLAN TEP IP, the Node’s
public ip and its encryption key to become part of the CIAB Mesh network.

#### Background Note

The Internet Assigned Numbers Authority (IANA) regulates what Port Numbers may be used
for what purposes on the Internet.
Port Number Ranges and Well Known Ports
A port number uses 16 bits and so can therefore have a value from 0 to 65535 decimal
Port numbers are divided into ranges as follows:
Port numbers 0-1023 – Well known port range. These are allocated to server services by the
Internet Assigned Numbers Authority (IANA). e.g Web servers normally use port 80 and SMTP
servers use port 25 (see diagram above).
Ports 1024-49151- Registered Port range -These can be registered for services with the IANA
and should be treated as semi-reserved. User written programs should not use these ports.

Ports 49152-65535 – These are used by client programs and you are free to use these in client
programs. When a Web browser connects to a web server the browser will allocate itself a port
in this range. Also known as ephemeral ports.
Given the previous Note, you should pick and use an Ephemeral Port Number between 49152-
65535 for your CIAB Mesh Internetwork configuration use.
For this document and our examples, I’ll use Port 50000.

### Step 8

Set public ip of `node1`, `node2` and `node3`, to each Node’s Public Interface IP address (note: either
IPv4 or IPv6 will work).

**Example:**

Suppose Node1 is a Cloud Instance and it’s Internet facing `<public ip>` address is
`132.65.71.21` then the command for Node1 would be:

    $ vwgen set ciabmesh node node1 endpoint '132.65.71.21:50000' listen-port 50000

Now, execute the following for each of your Nodes substituting each Node’s Public Interface IP address:

    $ vwgen set ciabmesh node node1 endpoint '\<public ip node1\>:50000' listen-port 50000
    $ vwgen set ciabmesh node node2 endpoint '\<public ip node2\>:50000' listen-port 50000
    $ vwgen set ciabmesh node node3 endpoint '\<public ip node3\>:50000' listen-port 50000

### Step 9

Show all information we have so far for cursory verification.

**IMPORTANT NOTE:**

The following will also show you each Node’s VTEP IP

    $ vwgen show ciabmesh | more

**Note:**

You may want to execute the above command now and record/copy the VTEP IP for
each Node.

### Step 10

`vwgen`, the VxWireguard-Generator tool, can be used to parse and extract from the Master Config file
(ciabvpn.conf), each Node’s individual Wireguard/VxLAN Config file.
Note: Repeat this for each Node or create a script to loop and do it for you

**Example:**

Use vwgen to extract each Node’s FRR config file from the Master config file.

    $ vwgen showconf ciabmesh node1 \> node1.conf
    $ vwgen showconf ciabmesh node2 \> node2.conf
    $ vwgen showconf ciabmesh node3 \> node3.conf

### Step 11
file located in that Node’s own:
/etc/wireguard/ciabmesh.conf
So for Node1, you will be copying node1.conf and renaming it to ciabmesh.conf in the /etc/wireguard
directory of the Node1 Server/VM/cloud-instance.
Note: When you installed FRR in Step 2 it would have created /etc/frr/
Step 12
Copy the Free Range Routing (FRR) CIAB BGP and VRF Configuration Template from this
document’s Appendix \#1 to each node’s /etc/frr/ directory and renaming it “frr.conf” (re
/etc/frr/frr.conf )
Step 13
Edit /etc/frr/frr.conf on each Node and where indicated in the template add the requested IP address
information.
Remember, you can get each Node’s VTEP (Virtual Tunnel End Point) IP address by executing in the
directory where you created the original “master” config file:
\$ vwgen show ciabmesh | more
Before Proceeding Please Reboot each of your Nodes Now !
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFgAAAGfCAIAAABUbYLbAAAACXBIWXMAABYlAAAWJQFJUiTwAAAB+klEQVR42u3QMQGAMAAEsQP/crs/K1sNJBJS8Pdss1C9CkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIECECESJEiBAhQoQIESJEiBAhQoQIESJEiBAhQoQIESJEiBAhQoQIESJEiBCBCBEiRIgQIUKECBEiRIgQIUKECBEiRIgQIUKECBEiRIgQIUKECBEiRIhAhAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkQgQoQIESJEiBAhQoQIESJEiBAhQoQIESJEiBAhQoQIESJEiBAhQoQIESIQIUKECBEiRIgQIUKECBEiRIgQIUKECBEiRIgQIUKECBEiRIgQIUKECBGIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgFIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIEIEIESJEiBAhQoQIESJEiBAhQoQIESJEiBAhQoQIESJEiBAhQoQIESJEiECECBEiRIgQIUKECBEiRIgQIUKECBEiRIgQIUKECBEiRIgQIUKECBEiRCBChAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIkSIECFChAgRIhAhQoSIm3OOhKptEqoPTvoMDCbq1UwAAAAASUVORK5CYII=)
Step 1 4
Start up the CIAB Mesh VPN Internetworking Overlay on each/all Nodes
SSH into each of your Nodes and start both Wireguard and FRR on all Nodes using the appropriate
CIAB MESH VPN utility bash script from those you copied to each node previously in Step \#4
In each Node execute:
\$ sudo wg-meshup.sh
\$ sudo frr-start.sh
\$ sudo bgp-restart.sh
Step 15
On each Node execute to show that Node’s interfaces information:
\$ ip addr
You should see several additional interfaces on each Node now, including:
vciabmesh The Node’s VxLAN VTEP Interface and IP
ciabmesh The Node’s Wireguard VPN Interface and IP
Validate that from any Host/Node you can now successfully Ping the IP address of any other
Host/Node’s LXD Container(s).
If there is a problem, often is with a mistake made entering IP addresses in one or more Node’s
/etc/frr/frr.conf file
Congratulations
You now have a fully encrypted, Full-Mesh VPN Overlay Network that should work with
your Servers and VM’s anywhere they are located whether in-house, inter-divisions, or
inter-Cloud to interconnect LXD Virtual Machines & LXD Containers.
Now your Applications and Users in any location can easily access Distributed
Applications and Databases etc anywhere in the Internet with CIAB’s MESH VPN.
Appendix \#1
Raw (ie uncommented) /etc/frr/frr.conf script follows
Note: copy this to create each node’s initial /etc/frr/frr.conf then edit that file
log syslog informational
hostname node1
password \<enter some password\>
enable password \<enter some "enable" password if you use FRR's VTYSH to do configs\>
router bgp 64512
bgp router-id \<insert "this" NODEs VTEP IP address here\>
\# bgp neighbors
neighbor \<insert Node1’s VTEP IP address here\> remote-as 64512
neighbor \<insert Node2’s VTEP IP address here\> remote-as 64512
neighbor \<insert Node3’s VTEP IP address here\> remote-as 64512
\# route reflectors
neighbor \<insert Node1’s VTEP IP address here\> route-reflector-client
neighbor \<insert Node2’s VTEP IP address here\> route-reflector-client
neighbor \<insert Node3’s VTEP IP address here\> route-reflector-client
\# Identify this Node’s LXD network (on Host execute \$ lxc list command).
\# This will advertise each Node’s LXD network through the
\# BGP Route Reflector’s to the other Nodes in the CIAB Mesh VPN.
network 10.0.1.0/24
Appendix \#2
Fully commented /etc/frr/frr.conf script
CIAB BGP and VRF Configuration Template for Nodes in a CIAB Secure Mesh Internet Overlay.
\#===================================================================
\# Name: CIAB BGP and VRF Configuration Template
\# CIAB Mesh VPN using BGP, WireGuard and VxLAN
\# 2019 Brian Mullan (bmullan.mail@gmail.com)
\#===================================================================
\# The following is the BGP and BGP Route Reflector Config file for
\# each NODE in the CIAB MeshVPN.
\#
\# There are comments explaining where and what to change for each
\# individual NODE.
\#
\# Copy this Template and edit it to insert appropriate IP addresses etc.
\#
\# Then SCP the template file to its corresponding Server/Host/Node
\# and rename it on each node to "/etc/frr/frr.conf" as it will become the Free Range Routing's
\# (FRR) config file when FRR is run.
\#
\#==={Begin FRR BGP Configuration - Copy everything below this line}==
\#
\# NOTE:
\#
\# If you use Quagga comments begin with an exclamation "!"
\# If you use FRR you can use either a Hash or exclamation mark.
\# I recommend using FRR as it seems to be moving faster that quaga todaay.
\#
\#===================================================================
\# Default to using syslog. /etc/rsyslog.d/45-frr.conf places the log
\# in /var/log/frr/frr.log
log syslog informational
\#===================================================================
\# CIAB Ubuntu BGP and BGP Route Reflectors Configuration
\# Each Node will require is FRR config file located in - /etc/frr/frr.conf
\#
\# 2016 brian mullan (ciab) for Architectural Design combining
\# LXD, BGP, BGP Route Reflectors, VxLAN and WireGuard to create
\# an Internet Overlay Network VPN.
\#===================================================================
\# FRR BGPd configuration file for CIAB network node.
\#
\# Node’s FRR config includes the Virtual Routing and Forwarding (re VRFs)
\# defined for each of the other LXD Host/Server nodes in the rest of the CIAB Mesh Network.
\#===================================================================
hostname node1
password \<enter some password\>
enable password \<enter some "enable" password if you use FRR's VTYSH to do configs\>
\#===================================================================
\# bgp multiple-instances...
\#===================================================================
\# Define Autonomous System (AS) number to use with BGP (re 64512) and Tenant Network.
\#
\# IMPORTANT NOTES:
\#
\# 1) You can ONLY use IANA approved "Private" AS Numbers.
\# REFER to Section 5 - https://tools.ietf.org/html/rfc6996
\#
\# 2) Both Quagga & FRR BGPd support "multiple VRF instance"
\# configurations where in the Config you can designate
\# Multiple AS Numbers. To utilize this in multi-tenant use-cases
\# please research this topic if your intent is to implement one unique AS number
\# for each Multi-Tenant.
\#
\# The FRR Documentation for this topic can be found here:
\# http://docs.frrouting.org/en/latest/bgp.html\#multiple-autonomous-systems
\#
\# Although this Guide/Template doesn’t cover Multi-Instance BGP AS configuration
\# If more than one AS is defined then a Node’s BGP would know to participate in more than
\# node AS Network.
\#===================================================================
\#==={Define Tenant BGP AS numbers}===
\# BGP AS for tenant1
router bgp 64512
\#===================================================================
\# Node0 is a Node using its VRFs to provide
\# Routing information to each of its Peers.
\#
\# Add BGP Peer nodes. One entry for each WireGuardud LXD Host/Server
\# node using that Host/Server's VxLAN Tunnel End Point (TEP)
\# interface IP address and the same Autonomous System (AS) number as
\# defined above.
\#
\#===================================================================
\# ID “this” BGP Node by its own VxLAN Tunnel End Point (TEP) IP
\# address. These will the 172.20.10.x addresses from our IPv4 “Pool” we specified
\# when we used vx-wireguard-generator to create the Master config file and later
\# extracted each Node’s individual WireGuard config.
\#===================================================================
bgp router-id \<insert "this" Node’s VTEP IP address here\>
\#===================================================================
\# As Node0 is a Node using its VRFs to provide
\# Routing information to each of its sub-ordinate Peers.
\#
\# Add BGP Peer nodes. One entry for each WireGuardud LXD Host/Server
\# Node using that Host/Server's WireGuard VxLAN interface IP address
\# and the same Autonomous System (AS) number as defined above.
\#
\# NOTE:
\# Again, if this is a Multi-Tenant or a Multi-Network configuration
\# EACH of these "could" be in a different AS Number which would
\# effectively separate Traffic like a VPN would do except this would
\# also Route via BGP.
\#
\# This Node0 would have to have more than 1 "router bgp \<AS number\>"
\# statement though so it’d know to participate in more than one BGP
\# AS network routing operation.
\#
\#===================================================================
\# Format:
\# neighbor \<WireGuard Node1’s VTEP IP\> \<AS number\>
\#
\#
\# Hint: If you were configuring with FRR BGP Multi-AS support you could “conceptually”
\# think of each BGP AS number as a Tenant ID. Again, we are not doing that here.
\# Node0 -
neighbor \<insert VTEP IP address here\> remote-as 64512
\# Node1 -
neighbor \<insert VTEP IP address here\> remote-as 64512
\# Node2 -
neighbor \<insert VTEP IP address here\> remote-as 64512
\#==={example Route Reflector config statements}======================
\# we ID the Route Reflector Clients nodes
\# Node0 -
neighbor \<insert VTEP IP address here\> route-reflector-client
\# Node1 -
neighbor \<insert VTEP IP address here\> route-reflector-client
\# Node2 -
neighbor \<insert VTEP IP address here\> route-reflector-client
\#==================================================================
\# Tell BGP to advertise/share "this" NODE's "local" LXD IP Subnet (/24 subnet of LXDBR0)
\# route info to its BGP AS Peers
\# NOTE 1: my example is using 10.0.1.x, yours is likely different
\# NOTE 2: you can list multiple LXD subnets here if you have more than one LXD bridge
\#==================================================================
network 10.0.1.0/24
![](data:image/png;base64,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)
