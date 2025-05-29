#!/bin/bash

if [[ "$2" = "up" ]]; then
    docker compose --env-file .env -f docker/$1/docker-compose.yml up -d
elif [[ "$2" = "down" ]]; then
    docker compose -f docker/$1/docker-compose.yml down
elif [[ "$2" = "restart" ]]; then
    docker compose --env-file .env -f docker/$1/docker-compose.yml restart 
else
    echo "Usage: ./dr.sh [name] [up/down/restart]"
fi

