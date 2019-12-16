#!/bin/bash

LOG_GROUP_PREFIX=$1
LOG_GROUP_RESULTS=$(aws logs describe-log-groups --log-group-name-prefix $LOG_GROUP_PREFIX | jq .[] | jq -r .[].logGroupName)

for i in $LOG_GROUP_RESULTS
do
  echo "Deleting $i"
  aws logs delete-log-group --log-group-name $i
done