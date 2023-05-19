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


function generate_node() {
  #printf "%s\n" "creating a node"
  IFS='|'
  nodes=(
    "$lnd_surge_config|"
    "$lnd_2_config|"
    "$lnd_3_config"
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

function generate_amt() {
    ceil=10000000
    floor=10000
    amount=$(((RANDOM % $(($ceil- $floor))) + $floor))
    echo "$amount"
}

function generate_memo() {
    words=(
        "piano" "balance" "transaction" "exchange" "receipt" "wire" "deposit" "wallet" "sats" "profit" "transfer"
        "vendor" "investment" "payment" "debit" "card" "bank" "account" "money" "order" "gateway" "online" "confirmation"
        "interest" "fraud" "Olivia" "Elijah" "Ava" "Liam" "Isabella" "Mason" "Sophia" "William" "Emma" "James" "parrot"
        "dolphin" "breeze" "moonlight" "whisper" "velvet" "marble" "sunset" "seashell" "peacock" "rainbow" "guitar"
        "harmony" "lullaby" "crystal" "butterfly" "stardust" "cascade" "serenade" "lighthouse" "orchid" "sapphire"
        "silhouette" "tulip" "firefly" "brook" "feather" "mermaid" "twilight" "dandelion" "morning" "serenity" "emerald"
        "flamingo" "gazelle" "ocean" "carousel" "sparkle" "dewdrop" "paradise" "polaris" "meadow" "quartz" "zenith"
        "horizon" "sunflower" "melody" "trinket" "whisker" "cabana" "harp" "blossom" "jubilee" "raindrop" "sunrise"
        "zeppelin" "whistle" "ebony" "gardenia" "lily" "marigold" "panther" "starlight" "harmonica" "shimmer" "canary"
        "comet" "moonstone" "rainforest" "buttercup" "zephyr" "violet" "serenade" "swan" "pebble" "coral" "radiance"
        "violin" "zodiac" "serenade"
    )

    sentence=""
    length=$((RANDOM % 5 + 4))  # Random sentence length between 4 and 8 words

    for ((i=0; i<length; i++)); do
        index=$((RANDOM % ${#words[@]}))
        word="${words[index]}"
        sentence+=" $word"
    done

    echo "${sentence:1}"  # Remove leading space before echoing the sentence
}

keysend() {
    source=$(generate_node -s $lnd_3_config)
    amt=$(generate_amt)
    printf "keysend:\n source %s\n  destination %s\n" "$source" "$addr_lnd_3"
    $lncli $source  sendpayment -f --dest=$addr_lnd_3 --amt=$amt --keysend
    printf "completed send keysend from %s to %s" $source $addr_lnd_3
}

invoice() {
   source=$(generate_node)
   destination=$(generate_node)
   amt=$(generate_amt) 
   memo=$(generate_memo)
   printf "invoice:\n source: %s\n destination: %s\n amt: %s\n memo: %s\n" "$source" "$destination" "$amt" "$memo"
   payment_req=$($lncli $destination addinvoice --memo "$memo" --amt $amt | jq ".payment_request" -r )
   echo  "$payment_req"
   printf " payment_req %s\n" "$payment_req"
   $lncli $source payinvoice -f $payment_req
   printf "completed send single htlc from %s to %s" $source $destination
}


amp() {
   source=$(generate_node)
   printf "source %s\n" "$source"
   destination=$(generate_node -s $source)
   amt=$(generate_amt)
   printf "invoice:\n source %s\n destination %s\n amt: %s\n memo: %s\n" "$source" "$destination" "$amt" "$memo"
   payment_req=$($lncli $source addinvoice --memo "$memo" --amt $amt --amp | jq ".payment_request" -r )
   $lncli $destination payinvoice -f $payment_req --amp
   printf "completed send amp (many htlcs) from %s to %s" $source $destination
}

keysend
amp
invoice

printf "\n%s\n" "completed send_payments.sh"
