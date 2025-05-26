#!/bin/bash

if [[ "$1" = "up" ]]; then
    docker compose --env-file .env -f docker/$2/docker-compose.yml up -d
elif [[ "$1" = "down" ]]; then
    docker compose -f docker/$2/docker-compose.yml down
elif [[ "$1" = "restart" ]]; then
    docker compose --env-file .env -f docker/$2/docker-compose.yml restart 
else
    echo "Usage: ./dr.sh [up/down/restart] [name]"
fi

