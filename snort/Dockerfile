FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y snort iproute2 net-tools && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/log/snort /etc/snort/rules
COPY snort.conf /etc/snort/snort.conf
COPY rules/local.rules /etc/snort/rules/local.rules
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
