#!/bin/sh
# This variable should be set manually.
ES_HOST="http://localhost:9200"

DATA_FOLDER="data"

BLOOMSKY_FILE_NAME=$DATA_FOLDER/bloomsky.json
ES_FILE_NAME=$DATA_FOLDER/es.json
ES_INDEX_FILE_NAME=mapping.txt

ES_INDEX_URL=$ES_HOST/bloomsky-$(date +%F)
ES_URL=$ES_HOST/bloomsky/doc/_bulk?pretty

echo "---------=======----------"
echo "Getting data from Bloomsky API!"
Bloomsky_API_intl.sh > $BLOOMSKY_FILE_NAME

echo "Parsing data in $BLOOMSKY_FILE_NAME started at $(date +%F_%R)."
parse-bloomsky-json.sh $BLOOMSKY_FILE_NAME > $ES_FILE_NAME

echo "Upload parsed data in $ES_FILE_NAME started at $(date +%F_%R)."
curl -H 'Content-Type: application/x-ndjson' -XPOST $ES_URL --data-binary @$ES_FILE_NAME
echo "Upload is finished!"

echo "---------=======----------"