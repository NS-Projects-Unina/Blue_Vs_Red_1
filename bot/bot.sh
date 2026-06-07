#!/bin/sh

echo "Bot di simulazione traffico avviato..."

# Loop di attesa iniziale opzionale
sleep 5 

while true; do
    # -k ignora i certificati, --tlsv1.0 forza la compatibilità con i vecchi cipher
    curl -k -s -o /dev/null -w "Risposta proxy: %{http_code}\n" --tlsv1.0 https://proxy/admin
    sleep 2
done