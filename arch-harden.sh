#!/bin/bash
###############################################
###### Ghost Node Hardening Script############# 
######  by hansolo5589-Mohd Firoz ############# 
####### Usage: sudo ./harden.sh ###############
###############################################
###############################################

set -e

echo "[+] Starting Ghost Node hardening..."

# 1. Disable IPv6
cat <<EOF > /etc/sysctl.d/99-disable-ipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF
sysctl -p /etc/sysctl.d/99-disable-ipv6.conf

# 2. Configure DNS-over-TLS and Silence Discovery
cat <<EOF > /etc/systemd/resolved.conf
[Resolve]
DNS=9.9.9.9 149.112.112.112
FallbackDNS=9.9.9.9 149.112.112.112
DNSStubListener=no
DNSOverTLS=yes
MulticastDNS=no
LLMNR=no
EOF

# Restart systemd-resolved to apply changes
systemctl restart systemd-resolved

# 3. Configure MAC Randomization for NetworkManager
# This appends the randomization rule to existing connections
for file in /etc/NetworkManager/system-connections/*.nmconnection; do
    if ! grep -q "cloned-mac-address=random" "$file"; then
        echo "[wifi]" >> "$file"
        echo "cloned-mac-address=random" >> "$file"
        echo "[ethernet]" >> "$file"
        echo "cloned-mac-address=random" >> "$file"
    fi
done

systemctl restart NetworkManager

echo "[+] Ghost Node configuration complete."
echo "[+] Verify status with: resolvectl status"
echo "[+] Verify MAC with: ip link show"
