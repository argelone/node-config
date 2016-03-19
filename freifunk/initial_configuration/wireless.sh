#!/bin/sh
uci -q batch <<EOF
        delete wireless.radio0.disabled                 # WLAN Einschalten
        delete wireless.@wifi-iface[0]                  # OpenWRT-Default WLAN loeschen
        set wireless.radio0.channel='1'                 # Funkeinstellungen
        set wireless.radio0.htmode='HT20'
        set wireless.radio0.country='DE'
        
        set wireless.wifi_freifunk='wifi-iface'         # 1. WLAN: Accesspoint
        set wireless.wifi_freifunk.device='radio0'
        set wireless.wifi_freifunk.network='freifunk'
        set wireless.wifi_freifunk.mode='ap'
        set wireless.wifi_freifunk.ssid='Freifunk'
        
        set wireless.wifi_mesh='wifi-iface'             # 2. WLAN: Ad-Hoc Mesh
        set wireless.wifi_mesh.device='radio0'
        set wireless.wifi_mesh.network='mesh babel_mesh'
        set wireless.wifi_mesh.mode='adhoc'
        set wireless.wifi_mesh.ssid='42:42:42:42:42:42'
        set wireless.wifi_mesh.bssid='42:42:42:42:42:42'
        set wireless.wifi_mesh.mcast_rate='12000'
        commit wireless
EOF