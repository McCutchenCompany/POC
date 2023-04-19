#!/bin/bash
squid -f /etc/squid/squid.conf
chromium-browser --no-sandbox --proxy-server=http://localhost:3128 https://auth.wyze.com/login
