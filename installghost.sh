#!/bin/bash
##################################################
# Main Installer Easy single execution          ##
# by Hansolo5589-Mohd Firoz                     ##
# usage: just ./installghost.sh                 ##
# Please make sure to make it execcutable first ##
##################################################


echo "[+] Starting Ghost Node Deployment..."
./checkfirewall.sh
sudo cp nftables.conf /etc/nftables.conf
sudo ./arch-harden.sh
echo "[+] Node hardened. System is now invisible."
