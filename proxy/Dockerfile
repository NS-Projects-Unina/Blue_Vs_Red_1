FROM vulnerables/cve-2014-0160
RUN a2enmod proxy proxy_http

RUN rm -f /etc/apache2/sites-enabled/*

COPY apache-proxy.conf /etc/apache2/sites-enabled/000-proxy-ssl

RUN echo "deb http://archive.debian.org/debian wheezy main contrib non-free" | tee /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN apt-get install -y --force-yes curl gnupg apt-transport-https
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
RUN echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
RUN apt-get update 
RUN WAZUH_MANAGER="wazuh.manager" apt-get install -y --force-yes wazuh-agent
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]