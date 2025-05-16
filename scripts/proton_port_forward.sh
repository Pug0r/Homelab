#!/bin/bash

natpmpc -a 1 0 udp 60 -g 10.2.0.1
mapped_port=$(natpmpc -a 1 0 tcp 60 -g 10.2.0.1 | awk '/Mapped public port/ {print $4}')
python3 set_listen_port.py $mapped_port
