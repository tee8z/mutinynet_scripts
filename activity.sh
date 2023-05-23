#!/bin/bash
source /home/pi/mutinynet_scripts/generate_channels.sh
for i in {1..6}; do  
        source /home/pi/mutinynet_scripts/send_payments.sh
done

