# CIAB Utility Scripts

Copy (scp) all of the CIAB Mesh VPN Utility Bash scripts to each Node into a
directory where you can execute them and make all of the CIAB Mesh VPN Utility
Bash scripts executable.

| Name                  | Purpose    |
|-----------------------|------------|
| wg-meshup.sh          |  Start Wireguard on a Node|
| wg-meshdown.sh        |  Shutdown Wireguard on a Node|
| frr-start.sh          |  Start FRR on a Node NOTE: Wireguard must be UP on a Node before Starting FRR|
| frr-restart.sh        |  Stop then Start FRR on a Node|
| frr-status.sh         |  Show FRR Status on a Node|
| frr-stop.sh           |  Stop FRR on a Node|
| bgp-start.sh          |  Start FRR’s BGP on a Node. NOTE: you must start FRR before executing this script.|
| bgp-restart.sh        |  Stop/Start FRR’s BGP on a Node. NOTE: you must start FRR before executing this script.|
| bgp-stop.sh           |  Stop FRR’s BGP on a Node|
| generate-ipv6-address |  Used by wg-meshup.sh to assign a unique IPv6 address to that node’s Wireguard Interface.|
| generate-ipv6-address |  generates IPv6 addresses from a given prefix and either a given MAC-48 address (an Ethernet hardware address) or a randomly drawn host number. NOTE: this script is a compiled binary program whose Source Code can be found on Github at: https://github.com/althea-net/generate-ipv6-address|

