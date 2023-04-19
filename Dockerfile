# Use a base image with Guacamole pre-installed
FROM oznu/guacamole

# Install Google Chrome browser
RUN apt-get update && apt-get install -y wget gnupg
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable

# Configure Guacamole to use Chrome
RUN echo 'user-mapping:disabled:disabled' >> /etc/guacamole/guacamole.properties
RUN echo '[remoteapp]' >> /etc/guacamole/guacamole.properties
RUN echo 'type=rdesktop' >> /etc/guacamole/guacamole.properties
RUN echo 'hostname=localhost' >> /etc/guacamole/guacamole.properties
RUN echo 'port=3389' >> /etc/guacamole/guacamole.properties
RUN echo 'username=guacuser' >> /etc/guacamole/guacamole.properties
RUN echo 'password=guacpassword' >> /etc/guacamole/guacamole.properties
RUN echo 'domain=wyze.com' >> /etc/guacamole/guacamole.properties
RUN echo 'security=nla' >> /etc/guacamole/guacamole.properties
RUN echo 'enable-printing=true' >> /etc/guacamole/guacamole.properties

# Expose Guacamole and Chrome ports
EXPOSE 8080 3389

# Start Guacamole and Chrome
CMD ["sh", "-c", "/usr/local/bin/guacd -b 0.0.0.0 && google-chrome-stable --no-sandbox --disable-setuid-sandbox --disable-gpu --remote-debugging-port=9222 https://auth.wyze.com/login"]
