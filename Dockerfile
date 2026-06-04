FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    net-tools \
    iputils-ping \
    nmap \
    && rm -rf /var/lib/apt/lists/*

# Struttura directory web
RUN mkdir -p /var/www/html \
             /var/www/uploads

# Copia file applicazione
COPY app/server.py  /var/www/server.py
COPY app/index.html /var/www/html/index.html

# Flag nascosta — solo root può leggerla
COPY flag/flag.txt  /root/flag.txt
RUN chmod 600 /root/flag.txt

# Permessi server
RUN chmod +x /var/www/server.py

WORKDIR /var/www

EXPOSE 8888

CMD ["python3", "server.py"]
