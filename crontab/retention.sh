#!/bin/bash

. /cronenv

indexes=$(curl -s elasticsearch:9200/_aliases?pretty=1 | grep -o logstash.*[0-9] | sort)
keep_indexes=$(echo "$indexes" | tail -"$DAYS_TO_KEEP")

for index in $indexes; do
  if ! [[ "$keep_indexes" =~ $index ]]; then
    echo "INFO: Removing index: $index"
    curl -s -XDELETE "elasticsearch:9200/${index}"
  fi
done
