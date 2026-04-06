FROM ubuntu:22.04
RUN apt-get update && apt-get install -y bind9 bind9-utils dnsutils && rm -rf /var/lib/apt/lists/*
COPY named.conf /etc/bind/named.conf
COPY db.cloud.local /etc/bind/db.cloud.local
EXPOSE 53/tcp 53/udp
CMD ["named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]
