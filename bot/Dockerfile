FROM ubuntu:14.04
RUN apt-get update && apt-get install -y curl
COPY bot.sh /bot.sh
RUN chmod +x /bot.sh
CMD ["/bot.sh"]