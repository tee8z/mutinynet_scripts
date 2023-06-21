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


lnd_4_config="--lnddir=/mount/ssd/lnd/signet4 --rpcserver=localhost:10012 --macaroonpath=/mount/ssd/lnd/signet4/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_4=$($lncli $lnd_4_config getinfo | jq -r '.uris[0]')
echo $addr_lnd_4

lnd_5_config="--lnddir=/mount/ssd/lnd/signet5 --rpcserver=localhost:10013 --macaroonpath=/mount/ssd/lnd/signet5/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_5=$($lncli $lnd_5_config getinfo | jq -r '.uris[0]')
echo $addr_lnd_5

lnd_6_config="--lnddir=/mount/ssd/lnd/signet6 --rpcserver=localhost:10014 --macaroonpath=/mount/ssd/lnd/signet6/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_6=$($lncli $lnd_6_config getinfo | jq -r '.uris[0]')
echo $addr_lnd_6

lnd_7_config="--lnddir=/mount/ssd/lnd/signet7 --rpcserver=localhost:10015 --macaroonpath=/mount/ssd/lnd/signet7/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_7=$($lncli $lnd_7_config getinfo | jq -r '.uris[0]')
echo $addr_lnd_7


connect_1_to_2=$($lncli $lnd_surge_config connect $addr_lnd_2)
echo $connect_1_to_2

connect_2_to_3=$($lncli $lnd_2_config connect $addr_lnd_3)
echo $connect_2_to_3

connect_3_to_1=$($lncli $lnd_3_config connect $addr_lnd_surge)
echo $connect_3_to_1

connect_4_to_2=$($lncli $lnd_4_config connect $addr_lnd_2)
echo $connect_4_to_2

connect_6_to_5=$($lncli $lnd_6_config connect $addr_lnd_5)
echo $connect_6_to_5

connect_5_to_3=$($lncli $lnd_5_config connect $addr_lnd_3)
echo $connect_5_to_3

connect_4_to_6=$($lncli $lnd_4_config connect $addr_lnd_6)
echo $connect_4_to_6


connect_1_to_5=$($lncli $lnd_surge_config connect $addr_lnd_5)
echo $connect_1_to_5

connect_2_to_6=$($lncli $lnd_2_config connect $addr_lnd_6)
echo $connect_2_to_6

connect_4_to_2=$($lncli $lnd_4_config connect $addr_lnd_2)
echo $connect_4_to_2

connect_1_to_6=$($lncli $lnd_surge_config connect $addr_lnd_6)
echo $connect_1_to_6

connect_4_to_3=$($lncli $lnd_4_config connect $addr_lnd_3)
echo $connect_4_to_3

connect_7_to_2=$($lncli $lnd_7_config connect $addr_lnd_2)
echo $connect_7_to_2

connect_7_to_2=$($lncli $lnd_7_config connect $addr_lnd_5)
echo $connect_7_to_5

connect_7_to_2=$($lncli $lnd_7_config connect $addr_lnd_6)
echo $connect_7_to_6

connect_7_to_2=$($lncli $lnd_7_config connect $addr_lnd_3)
echo $connect_7_to_3

