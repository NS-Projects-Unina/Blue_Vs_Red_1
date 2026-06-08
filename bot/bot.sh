#!/bin/sh

echo "Bot di simulazione traffico avviato..."
echo "Iniezione della Flag nel tunnel SSL in corso..."

# Attesa iniziale per dare tempo al proxy di avviarsi
sleep 5 

while true; do
    # -k: ignora il certificato autofirmato
    # --tlsv1.0: forza il vecchio protocollo compatibile con Heartbleed
    # -H: inietta la flag nei cookie e nelle intestazioni HTTP
    curl -k -s -o /dev/null -w "Risposta proxy: %{http_code}\n" \
         --tlsv1.0 \
         -H "Cookie: session=admin_authenticated; ctf_flag=CTF{H34rtbl33d_M3m0ry_L34k_Succ3ss}" \
         -H "X-Custom-Auth: CTF{H34rtbl33d_M3m0ry_L34k_Succ3ss}" \
         https://proxy/admin
         
    # Invia una richiesta ogni secondo per mantenere la flag stabile nella RAM di OpenSSL
    sleep 1
done