#!/bin/sh

# Das Script kann nur einmal ausgeführt werden
if [ -f /lib/freifunk/config_import_done ];then
  echo "Konfiguration wurde bereits importiert"
  exit 0
fi
touch /lib/freifunk/config_import_done

# Importiere vorhandene Konfiguration
# Firwall und ebtables haben eine Sonderrolle: 
# Die Konfiguration kann nicht einfach per uci merged werden und wird per Script aufgenommen
/lib/freifunk/initial_configuration/firewall.sh
/lib/freifunk/initial_configuration/wireless.sh
/lib/freifunk/initial_configuration/rules.sh

## Weitere Konfigurationen werden via uci import eingelesen und aufgenommen:
# firewall, dhcp, network und wireless ergänzen die vorhandene Konfiguration (-m)
# Bei allen anderen Paketen wird die vorhandene Konfiguration ersetzt
uci -m  import firewall  	< /lib/freifunk/initial_configuration/firewall.uci
uci -m import network 	 	< /lib/freifunk/initial_configuration/network.uci
uci -m import dhcp 		< /lib/freifunk/initial_configuration/dhcp.uci
uci -m import openvpn   	< /lib/freifunk/initial_configuration/openvpn.uci

uci import babeld 		< /lib/freifunk/initial_configuration/babeld.uci
uci import batman-adv 	< /lib/freifunk/initial_configuration/batman-adv.uci
uci import fastd 		< /lib/freifunk/initial_configuration/fastd.uci
uci import node_config 		< /lib/freifunk/initial_configuration/node_config.uci

# Fix binding
/lib/freifunk/initial_configuration/fastd_binding.sh

# Curser abschliessen
uci commit

