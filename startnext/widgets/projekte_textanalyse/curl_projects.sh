#!/bin/env/bash

echo "CURL Startnext Projects"

# Move into the data dir
cd $PWD/data

# Get all project json files
for i in {2..1954}
do
  echo "Request Project with ID $i"
  curl https://api.startnext.de/v1/projects/$i -s -o project_id_$i.json
done

echo "CURL Data Ready"
