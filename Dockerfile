FROM debian:bullseye-slim

# install ZeroTier + Samba
RUN apt-get update && apt-get install -y \
        curl ca-certificates samba \
    && curl -s https://install.zerotier.com | bash \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9993/udp 445/tcp

# create share directory and give it write access for everybody
RUN mkdir -p /shared \
 && chmod 777 /shared

# minimal smb.conf
RUN printf '%s\n' \
'[global]' \
'  map to guest = Bad User' \
'  server min protocol = SMB2' \
'  server max protocol = SMB3' \
'  security = user' \
'[shared]' \
'  path = /shared' \
'  read only = no' \
'  guest ok = yes' \
'  browsable = yes' \
'  create mask = 0644' \
'  directory mask = 0755' \
> /etc/samba/smb.conf

COPY <<'EOF' /main.sh
#!/bin/bash
set -e
smbd -D
nmbd -D
exec zerotier-one
EOF
RUN chmod +x /main.sh
ENTRYPOINT ["/main.sh"]
