FROM vulnerables/cve-2014-0160

# 1. Abilitiamo i moduli proxy
RUN a2enmod proxy proxy_http

# 2. DISTRUGGIAMO tutte le configurazioni di default per evitare conflitti
RUN rm -f /etc/apache2/sites-enabled/*

# 3. Piazziamo la nostra configurazione DIRETTAMENTE nei siti abilitati come unico sito
COPY apache-proxy.conf /etc/apache2/sites-enabled/000-proxy-ssl