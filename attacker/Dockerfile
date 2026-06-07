FROM metasploitframework/metasploit-framework

# Impedisce blocchi interattivi durante l'installazione dei pacchetti
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /root/privilege_escalation
COPY ./scripts/chwoot.sh /root/privilege_escalation

# Aggiorna i repository e installa Netcat e Metasploit
RUN apk add proxychains-ng \
        openssh \
        vim
RUN cd /root
RUN wget https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_linux_amd64.gz
RUN gunzip chisel_1.9.1_linux_amd64.gz
RUN mv chisel_1.9.1_linux_amd64 chisel
RUN chmod +x chisel

CMD ["/usr/src/metasploit-framework/msfconsole"]