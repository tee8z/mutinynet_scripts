#!/bin/bash
lncli="/home/pi/lnd/lncli"

lnd_3_config="--lnddir=/mount/ssd/lnd/signet3 --rpcserver=localhost:10011 --macaroonpath=/mount/ssd/lnd/signet3/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_3=$($lncli $lnd_3_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_3


lnd_4_config="--lnddir=/mount/ssd/lnd/signet4 --rpcserver=localhost:10012 --macaroonpath=/mount/ssd/lnd/signet4/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_4=$($lncli $lnd_4_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_4


lnd_5_config="--lnddir=/mount/ssd/lnd/signet5 --rpcserver=localhost:10013 --macaroonpath=/mount/ssd/lnd/signet5/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_5=$($lncli $lnd_5_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_5


lnd_7_config="--lnddir=/mount/ssd/lnd/signet7 --rpcserver=localhost:10015 --macaroonpath=/mount/ssd/lnd/signet7/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_7=$($lncli $lnd_7_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_7

channel_7_to_3=$($lncli $lnd_7_config openchannel $addr_lnd_3 5000000)
echo $channel_7_to_3

channel_4_to_7=$($lncli $lnd_4_config openchannel $addr_lnd_7 5000000)
echo $channel_4_to_7

channel_5_to_7=$($lncli $lnd_5_config openchannel $addr_lnd_7 5000000)
echo $channel_5_to_7


channel_7_to_5=$($lncli $lnd_7_config openchannel $addr_lnd_5 2000000)
echo $channel_7_to_5
