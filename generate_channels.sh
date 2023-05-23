#!/bin/bash

lncli="/home/pi/lnd/lncli"
declare -A node_uris

lnd_surge_config="--lnddir=/mount/ssd/lnd/signet --macaroonpath=/mount/ssd/lnd/signet/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_surge=$($lncli $lnd_surge_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_surge
node_uris["$addr_lnd_surge"]=$($lncli $lnd_surge_config getinfo | jq -r '.uris[0]')

lnd_2_config="--lnddir=/mount/ssd/lnd/signet2 --rpcserver=localhost:10010 --macaroonpath=/mount/ssd/lnd/signet2/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_2=$($lncli $lnd_2_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_2
node_uris["$addr_lnd_2"]=$($lncli $lnd_2_config getinfo | jq -r '.uris[0]')

lnd_3_config="--lnddir=/mount/ssd/lnd/signet3 --rpcserver=localhost:10011 --macaroonpath=/mount/ssd/lnd/signet3/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_3=$($lncli $lnd_3_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_3
node_uris["$addr_lnd_3"]=$($lncli $lnd_3_config getinfo | jq -r '.uris[0]')

lnd_4_config="--lnddir=/mount/ssd/lnd/signet4 --rpcserver=localhost:10012 --macaroonpath=/mount/ssd/lnd/signet4/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_4=$($lncli $lnd_4_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_4
node_uris["$addr_lnd_4"]=$($lncli $lnd_4_config getinfo | jq -r '.uris[0]')


lnd_5_config="--lnddir=/mount/ssd/lnd/signet5 --rpcserver=localhost:10013 --macaroonpath=/mount/ssd/lnd/signet5/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_5=$($lncli $lnd_5_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_5
node_uris["$addr_lnd_5"]=$($lncli $lnd_5_config getinfo | jq -r '.uris[0]')


lnd_6_config="--lnddir=/mount/ssd/lnd/signet6 --rpcserver=localhost:10014 --macaroonpath=/mount/ssd/lnd/signet6/data/chain/bitcoin/signet/admin.macaroon"
addr_lnd_6=$($lncli $lnd_6_config getinfo | jq '.identity_pubkey' -r)
echo $addr_lnd_6
node_uris["$addr_lnd_6"]=$($lncli $lnd_6_config getinfo | jq -r '.uris[0]')


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
echo $channel_sats



function generate_node() {
  #printf "%s\n" "getting a node's connection"
  IFS='|'
  nodes=(
    "$lnd_surge_config|"
    "$lnd_2_config|"
    "$lnd_3_config|"
    "$lnd_4_config|"
    "$lnd_5_config|"
    "$lnd_6_config|"
  )
  num_of_nodes=${#nodes[@]}
  if [[ "$1" == "-s" ]]; then
    skip_node=$2
    #printf "skip_node %s\n" "$skip_node"
    if [[ ! " ${nodes[@]} " =~ " $skip_node " && ! " ${nodes[@]} " =~ " $skip_node| "  ]]; then
      printf "%s\n" "The specified node is not in the list."
      exit 1
    fi

    nodes=("${nodes[@]/$skip_node}")
    num_of_nodes=${#nodes[@]}
  fi
  pick=$((RANDOM % num_of_nodes))
  node=${nodes[$pick]}
  if [[ "${node: -1}" == "|" ]]; then
    # Drop the last character
    node="${node%?}"
  fi

  echo "$node"
}

function generate_node_address() {
  #printf "%s\n" "getting a node's address"
  IFS='|'
  nodes=(
    "$addr_lnd_surge|"
    "$addr_lnd_2|"
    "$addr_lnd_3|"
    "$addr_lnd_4|"
    "$addr_lnd_5|"
    "$addr_lnd_6|"
  )
  num_of_nodes=${#nodes[@]}
  if [[ "$1" == "-s" ]]; then
    skip_node=$2
    #printf "skip_node %s\n" "$skip_node"
    if [[ ! " ${nodes[@]} " =~ " $skip_node " && ! " ${nodes[@]} " =~ " $skip_node| "  ]]; then
      printf "%s\n" "The specified node is not in the list."
      exit 1
    fi
    nodes=("${nodes[@]/$skip_node}")
    num_of_nodes=${#nodes[@]}
  fi
  pick=$((RANDOM % num_of_nodes))
  node=${nodes[$pick]}
  if [[ "${node: -1}" == "|" ]]; then
    # Drop the last character
    node="${node%?}"
  fi

  echo "$node"
}



open_channel(){
   source=$(generate_node)
   destination=$(generate_node_address)
   printf "opening channel from %s to %s\n" "$source" "$destination"
   connect_as_peer=$($lncli $source connect ${node_uris[$destination]})
   echo $connect_as_peer
   open_channel=$($lncli $source openchannel $destination $channel_sats)
   echo $open_channel
}


close_channel(){
   source=$(generate_node)
   channel_point=$($lncli $source listchannels | jq -r '.channels[].channel_point' | shuf -n 1)
   echo $channel_point
   close_channel=$($lncli $source closechannel --chan_point $channel_point 2>&1)
   if echo "$close_channel" | grep -q "rpc error:"; then
    echo "trying to force close the channel"
    close_channel=$($lncli $source closechannel --chan_point $channel_point --force)
    echo $close_channel
   fi
   echo "closed channel"
}

close_channel

