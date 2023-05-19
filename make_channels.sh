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


lnd_4_config="--lnddir=/mount/ssd/lnd/signet4 --rpcserver=localhost:10012 --macaroonpath=/mount/ssd/lnd/signet4/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_4=$($lncli $lnd_4_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_4


lnd_5_config="--lnddir=/mount/ssd/lnd/signet5 --rpcserver=localhost:10013 --macaroonpath=/mount/ssd/lnd/signet5/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_5=$($lncli $lnd_5_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_5


lnd_6_config="--lnddir=/mount/ssd/lnd/signet6 --rpcserver=localhost:10014 --macaroonpath=/mount/ssd/lnd/signet6/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_6=$($lncli $lnd_6_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_6




channel_1_to_2=$($lncli $lnd_surge_config openchannel $addr_lnd_2 5000000)
echo $channel_1_to_2

channel_2_to_3=$($lncli $lnd_2_config openchannel $addr_lnd_3 5000000)
echo $channel_2_to_3

channel_3_to_1=$($lncli $lnd_3_config openchannel $addr_lnd_surge 5000000)
echo $channel_3_to_1

channel_4_to_2=$($lncli $lnd_4_config openchannel $addr_lnd_2 1000000)
echo $channel_4_to_2

channel_6_to_1=$($lncli $lnd_6_config openchannel $addr_lnd_surge 1000000)
echo $channel_6_to_1

channel_5_to_3=$($lncli $lnd_5_config openchannel $addr_lnd_3 1000000)
echo $channel_5_to_3

channel_3_to_4=$($lncli $lnd_3_config openchannel $addr_lnd_4 1000000)
echo $channel_3_to_4

channel_2_to_6=$($lncli $lnd_2_config openchannel $addr_lnd_6 1000000)
echo $channel_2_to_6

channel_1_to_5=$($lncli $lnd_surge_config openchannel $addr_lnd_5 1000000)
echo $channe_1_to_5
