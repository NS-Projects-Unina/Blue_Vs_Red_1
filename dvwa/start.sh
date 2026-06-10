#!/bin/bash

# =====================================================================
# CONFIGURAZIONE DINAMICA AGENT WAZUH
# =====================================================================
# WAZUH_MANAGER="${WAZUH_MANAGER:-wazuh.manager}"

# apt-get install gnupg apt-transport-https

# =====================================================================
# AVVIO DEI SERVIZI DI SISTEMA
# =====================================================================
#echo "[WAZUH] Avvio del servizio wazuh-agent..."
#service wazuh-agent start

echo "[SYSTEM] Avvio di MariaDB..."
service mariadb start [cite: 4]

echo "[SYSTEM] Avvio del server SSH..."
service ssh start [cite: 4]

# =====================================================================
# CONFIGURAZIONE PRIVILEGI DATABASE (DVWA)
# =====================================================================
echo "[DATABASE] Configurazione dei privilegi per DVWA..."
mysql -e "CREATE DATABASE IF NOT EXISTS dvwa;" [cite: 4]
mysql -e "CREATE USER IF NOT EXISTS 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';" [cite: 5]
mysql -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost';" [cite: 5]
mysql -e "FLUSH PRIVILEGES;" [cite: 6]

# =====================================================================
# AVVIO E SETUP DI APACHE
# =====================================================================
# Avvia Apache in background momentaneamente per eseguire il setup PHP
service apache2 start [cite: 6]

# Aspetta un secondo per assicurarsi che Apache sia pronto
sleep 1 [cite: 6]

# Fermiamo il servizio Apache in background per evitare conflitti
service apache2 stop [cite: 6]

# Avvia Apache in primo piano (mantiene attivo il container)
echo "[SYSTEM] Avvio di Apache2 in primo piano..."
apache2ctl -D FOREGROUND [cite: 6]