#!/bin/bash
channel_sats=3000000  # Default channel size

# Parse command-line options
while getopts ":n:" opt; do
  case $opt in
    n)
      channel_sats=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
echo $amt_sats


lncli="/home/pi/lnd/lncli"
lnd_surge_config="--lnddir=/mount/ssd/lnd/signet --macaroonpath=/mount/ssd/lnd/signet/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_surge=$($lncli $lnd_surge_config getinfo | jq -r '.uris[0]')
echo $addr_lnd_surge

lnd_2_config="--lnddir=/mount/ssd/lnd/signet2 --rpcserver=localhost:10010 --macaroonpath=/mount/ssd/lnd/signet2/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_2=$($lncli $lnd_2_config getinfo | jq -r '.uris[0]')
echo $addr_lnd_2

lnd_3_config="--lnddir=/mount/ssd/lnd/signet3 --rpcserver=localhost:10011 --macaroonpath=/mount/ssd/lnd/signet3/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_3=$($lncli $lnd_3_config getinfo | jq -r '.uris[0]')
echo $addr_lnd_3

connect_1_to_2=$($lncli $lnd_surge_config connect $add_lnd_2)
echo $connect_1_to_2

connect_2_to_3=$($lncli $lnd_2_config connect $add_lnd_3)
echo $connect_2_to_3

connect_3_to_1=$($lncli $lnd_3_config connect $add_lnd_surge)
echo $connect_3_to_1
