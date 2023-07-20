#!/bin/bash
amt_sats=9000000  # Default value

# Parse command-line options
while getopts ":n:" opt; do
  case $opt in
    n)
      amt_sats=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
echo $amt_sats

lncli="/home/pi/lnd/lncli"
lnd_surge_config="--lnddir=/mount/ssd/lnd/signet --macaroonpath=/mount/ssd/lnd/signet/data/chain/bitcoin/signet/admin.macaroon"
addr_surge=$($lncli $lnd_surge_config newaddress p2tr | jq -r '.address')
tx_surge=$(curl -X POST \
  https://faucet.mutinynet.com/api/faucet \
  -H 'Content-Type: application/json' \
  -d '{"sats":"'"$amt_sats"'","address":"'"$addr_surge"'"}' | jq -r '.txid')
echo "lnd_surge address" $addr_surge " txid" $tx_surge " amt_sats" $amt_sats


lnd_2_config="--lnddir=/mount/ssd/lnd/signet2 --rpcserver=localhost:10010 --macaroonpath=/mount/ssd/lnd/signet2/data/chain/bitcoin/signet/admin.macaroon"
addr_2=$($lncli $lnd_2_config newaddress p2tr | jq -r '.address')
tx_2=$(curl -X POST \
  https://faucet.mutinynet.com/api/faucet \
  -H 'Content-Type: application/json' \
  -d '{"sats":"'"$amt_sats"'","address":"'"$addr_2"'"}' | jq -r '.txid')
echo ""
echo "lnd_2 address" $addr_2 " txid" $tx_2 " amt_sats" $amt_sats

lnd_3_config="--lnddir=/mount/ssd/lnd/signet3 --rpcserver=localhost:10011 --macaroonpath=/mount/ssd/lnd/signet3/data/chain/bitcoin/signet/admin.macaroon"
addr_3=$($lncli $lnd_3_config newaddress p2tr | jq -r '.address')
tx_3=$(curl -X POST \
  https://faucet.mutinynet.com/api/faucet \
  -H 'Content-Type: application/json' \
  -d '{"sats":"'"$amt_sats"'","address":"'"$addr_3"'"}' | jq -r '.txid')
echo ""
echo "lnd_3 address" $addr_3 " txid" $tx_3 " amt_sats" $amt_sats


lnd_4_config="--lnddir=/mount/ssd/lnd/signet4 --rpcserver=localhost:10012 --macaroonpath=/mount/ssd/lnd/signet4/data/chain/bitcoin/signet/admin.macaroon"
addr_4=$($lncli $lnd_4_config newaddress p2tr | jq -r '.address')
tx_4=$(curl -X POST \
  https://faucet.mutinynet.com/api/faucet \
  -H 'Content-Type: application/json' \
  -d '{"sats":"'"$amt_sats"'","address":"'"$addr_4"'"}' | jq -r '.txid')
echo ""
echo "lnd_4 address" $addr_4 " txid" $tx_4 " amt_sats" $amt_sats


lnd_5_config="--lnddir=/mount/ssd/lnd/signet5 --rpcserver=localhost:10013 --macaroonpath=/mount/ssd/lnd/signet5/data/chain/bitcoin/signet/admin.macaroon"
addr_5=$($lncli $lnd_5_config newaddress p2tr | jq -r '.address')
tx_5=$(curl -X POST \
  https://faucet.mutinynet.com/api/faucet \
  -H 'Content-Type: application/json' \
  -d '{"sats":"'"$amt_sats"'","address":"'"$addr_5"'"}' | jq -r '.txid')
echo ""
echo "lnd_5 address" $addr_5 " txid" $tx_5 " amt_sats" $amt_sats


lnd_6_config="--lnddir=/mount/ssd/lnd/signet6 --rpcserver=localhost:10014 --macaroonpath=/mount/ssd/lnd/signet6/data/chain/bitcoin/signet/admin.macaroon"
addr_6=$($lncli $lnd_6_config newaddress p2tr | jq -r '.address')
tx_6=$(curl -X POST \
  https://faucet.mutinynet.com/api/faucet \
  -H 'Content-Type: application/json' \
  -d '{"sats":"'"$amt_sats"'","address":"'"$addr_6"'"}' | jq -r '.txid')
echo ""
echo "lnd_6 address" $addr_6 " txid" $tx_6 " amt_sats" $amt_sats

lnd_7_config="--lnddir=/mount/ssd/lnd/signet7 --rpcserver=localhost:10015 --macaroonpath=/mount/ssd/lnd/signet7/data/chain/bitcoin/signet/admin.macaroon"
addr_7=$($lncli $lnd_7_config newaddress p2tr | jq -r '.address')
tx_7=$(curl -X POST \
  https://faucet.mutinynet.com/api/faucet \
  -H 'Content-Type: application/json' \
  -d '{"sats":"'"$amt_sats"'","address":"'"$addr_6"'"}' | jq -r '.txid')
echo ""
echo "lnd_7 address" $addr_7 " txid" $tx_7 " amt_sats" $amt_sats
