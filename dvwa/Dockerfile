FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Installa Apache, MariaDB, PHP e le estensioni necessarie
RUN apt-get update && apt-get install -y \
    apache2 \
    mariadb-server \
    php \
    php-mysqli \
    php-gd \
    php-curl \
    git \
    curl \ 
    python3 \
    openssh-server \
    build-essential \
    wget \
    libpam0g-dev libselinux1-dev zlib1g-dev \
    pkg-config \
    libssl-dev \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Compila una versione vulnerabile di sudo 
WORKDIR /opt
RUN wget https://www.sudo.ws/dist/sudo-1.9.16p2.tar.gz && \
    tar xzf sudo-1.9.16p2.tar.gz && \
    cd sudo-1.9.16p2 && \
    ./configure --disable-gcrypt --prefix=/usr && make && make install

RUN mkdir /var/run/sshd && \
    echo 'root:Wuj^4@3FLt2!CD' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Installa DVWA
RUN rm -rf /var/www/html/* && \
    git clone https://github.com/digininja/DVWA.git /var/www/html

# Copia il file di configurazione di esempio
RUN cp /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php

# Modifica al volo le credenziali del DB nel file config di DVWA per farle corrispondere a quelle create da root
RUN sed -i "s/'db_user'\]   = 'app'/'db_user'\]   = 'dvwa'/g" /var/www/html/config/config.inc.php && \
    sed -i "s/'db_password'\] = 'cyberaspace'/'db_password'\] = 'p@ssw0rd'/g" /var/www/html/config/config.inc.php

# Configura i permessi per permettere l'upload dei file nelle cartelle vulnerabili
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 777 /var/www/html/hackable/uploads

# Crea lo script di avvio aggiornato per eseguire anche il setup di DVWA
RUN cat << 'EOF' > /start.sh
#!/bin/bash
# 1. Avvia i servizi in background
service mariadb start
service ssh start

# 2. Configura i privilegi del Database
mysql -e "CREATE DATABASE IF NOT EXISTS dvwa;"
mysql -e "CREATE USER IF NOT EXISTS 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';"
mysql -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# 3. Avvia Apache in background momentaneamente per eseguire il setup PHP
service apache2 start

# Aspetta un secondo per assicurarsi che Apache sia pronto
sleep 1

# Fermiamo il servizio Apache in background per evitare conflitti
service apache2 stop

# 5. Avvia Apache in primo piano (mantiene attivo il container)
apache2ctl -D FOREGROUND
EOF

# Rendi lo script eseguibile
RUN chmod +x /start.sh

EXPOSE 80

# Imposta il livello di sicurezza iniziale di DVWA su 'low'
ENV DEFAULT_SECURITY_LEVEL=low

CMD ["/start.sh"]