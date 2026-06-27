#############################################################
#This will check to see if u have NFTABLES installed first.##
#         Usage: ./checkfirewall.sh       ###################
#         By : hansolo5589-Mohd Firoz     ###################
#############################################################



if ! command -v nft &> /dev/null; then
    echo "[-] nftables not found. Install it first."
    exit 1
fi

