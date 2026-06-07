#!/bin/bash
echo "[*] Attendo il Manager su 10.30.0.12..."
until curl -sk https://10.30.0.12:55000 > /dev/null 2>&1; do
    sleep 5
    echo "[*] Retry..."
done
echo "[*] Manager raggiungibile. Avvio agent..."
/var/ossec/bin/wazuh-control start
tail -f /var/ossec/logs/ossec.log
