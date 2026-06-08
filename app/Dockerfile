FROM python:3.9-slim

RUN apt-get update && apt-get install -y gnupg apt-transport-https curl
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
RUN apt-get update
RUN WAZUH_MANAGER="wazuh.manager" apt-get install -y wazuh-agent
RUN /var/ossec/bin/wazuh-control start
WORKDIR /app
RUN pip install flask redis
COPY app.py .
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["python", "app.py","/start.sh"]