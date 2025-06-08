#!/bin/bash

source ../.env

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <yt-link> <title>"
  exit 1
fi

URL="$1"
TITLE="$2"

dir_name="$EXTERNAL_MEMORY/data/podcasts/$TITLE"

mkdir -p "$dir_name"

yt-dlp -x --write-thumbnail -o "$dir_name/$TITLE.%(ext)s" "$URL"

