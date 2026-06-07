#!/bin/bash
sleep 5
echo "[*] Interfacce disponibili:"
ip link show
echo "[*] Avvio Snort su eth0 (ctf-net)..."
snort -A full -c /etc/snort/snort.conf -i eth0 -l /var/log/snort -D
echo "[*] Avvio Snort su eth1 (hidden-net)..."
snort -A full -c /etc/snort/snort.conf -i eth1 -l /var/log/snort -D
echo "[*] Snort attivo. Log in /var/log/snort/alert"
tail -f /var/log/snort/alert
