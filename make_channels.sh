#!/bin/bash
lncli="/home/pi/lnd/lncli"
lnd_surge_config="--lnddir=/mount/ssd/lnd/signet --macaroonpath=/mount/ssd/lnd/signet/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_surge=$($lncli $lnd_surge_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_surge

lnd_2_config="--lnddir=/mount/ssd/lnd/signet2 --rpcserver=localhost:10010 --macaroonpath=/mount/ssd/lnd/signet2/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_2=$($lncli $lnd_2_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_2

lnd_3_config="--lnddir=/mount/ssd/lnd/signet3 --rpcserver=localhost:10011 --macaroonpath=/mount/ssd/lnd/signet3/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_3=$($lncli $lnd_3_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_3

channel_1_to_2=$($lncli $lnd_surge_config openchannel $addr_lnd_2 5000000)
echo $channel_1_to_2

channel_2_to_3=$($lncli $lnd_2_config openchannel $addr_lnd_3 5000000)
echo $channel_2_to_3

channel_3_to_1=$($lncli $lnd_3_config openchannel $addr_lnd_surge 5000000)
echo $channel_3_to_1
