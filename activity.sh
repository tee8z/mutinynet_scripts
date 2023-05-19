#!/bin/bash

for i in {1..6}; do 
    for i in {1..6}; do 
        source /home/pi/mutinynet_script/send_payments.sh &
    done
done

wait
