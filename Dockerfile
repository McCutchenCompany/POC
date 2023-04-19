FROM ubuntu:20.04

# Install necessary packages
RUN sudo apt-get update && \
    sudo apt-get install -y \
    git \
    wget \
    xvfb \
    x11vnc \
    fluxbox \
    supervisor \
    net-tools \
    firefox \
    openssl \
    ca-certificates

# Copy the necessary files into the container
COPY guacamole.properties /etc/guacamole/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY startup.sh /startup.sh

# Set the permissions of startup.sh
RUN chmod +x /startup.sh

# Expose the necessary ports
EXPOSE 8080 5901

# Start Guacamole and VNC servers when the container starts
CMD ["/startup.sh"]
