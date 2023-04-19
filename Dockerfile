FROM ubuntu:latest
RUN apt-get update && \
    apt-get install libcrypt1 \
    apt-get install -y chromium-browser squid && \
    useradd -ms /bin/bash chromeuser && \
    mkdir -p /home/chromeuser/Downloads && \
    chown -R chromeuser:chromeuser /home/chromeuser

COPY squid.conf /etc/squid/
RUN chown proxy:proxy /etc/squid/squid.conf
USER chromeuser
WORKDIR /home/chromeuser
COPY startup.sh .
RUN chmod +x startup.sh
ENTRYPOINT ["./startup.sh"]
