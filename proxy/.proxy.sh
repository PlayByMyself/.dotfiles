#!/bin/bash

args=$1
if [[ "$args" == "up" ]]
then
    echo $args
    export https_proxy="http://127.0.0.1:1081"
    export http_proxy="http://127.0.0.1:1081"
elif [[ "$args" == "down" ]]
then
    echo $args
    unset https_proxy
    unset http_proxy
else
    echo "Usage: $0 up|down"
fi
