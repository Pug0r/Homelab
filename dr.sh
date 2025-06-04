#!/bin/bash

usage="Usage: ./dr.sh <name> <up/down/restart> [--all]"

if [ "$#" -lt 2 ]; then
  echo $usage
  exit 1
fi

name=$1
action=$2
all_flag=$3

if [ "$all_flag" == "--all" ]; then
  for dir in docker/*; do
    if [[ "$action" == "up" ]]; then
      docker compose --env-file .env -f $dir/docker-compose.yml up -d
    elif [[ "$action" == "down" ]]; then
      docker compose -f $dir/docker-compose.yml down
    elif [[ "$action" == "restart" ]]; then
      docker compose --env-file .env -f $dir/docker-compose.yml restart
    else
      echo $usage
      exit 1
    fi
  done
else
  if [[ "$action" == "up" ]]; then
    docker compose --env-file .env -f docker/$name/docker-compose.yml up -d
  elif [[ "$action" == "down" ]]; then
    docker compose -f docker/$name/docker-compose.yml down
  elif [[ "$action" == "restart" ]]; then
    docker compose --env-file .env -f docker/$name/docker-compose.yml restart
  else
    echo $usage
    exit 1
  fi
fi

