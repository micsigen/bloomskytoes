#!/bin/sh
# This variable should be set manually.
ES_HOST="http://localhost:9200"
PWD=`pwd`
DATA_FOLDER=$PWD"/data"

BLOOMSKY_FILE_NAME=$DATA_FOLDER/bloomsky.json
ES_FILE_NAME=$DATA_FOLDER/es.json
ES_URL=$ES_HOST/bloomsky/doc/_bulk?pretty

echo "$(date +%F_%R:%S): Getting data from Bloomsky API to $BLOOMSKY_FILE_NAME."
$PWD/Bloomsky_API_intl.sh > $BLOOMSKY_FILE_NAME

echo "$(date +%F_%R:%S): Parsing data from $BLOOMSKY_FILE_NAME to $ES_FILE_NAME started."
$PWD/parse-bloomsky-json.sh $BLOOMSKY_FILE_NAME > $ES_FILE_NAME

echo "$(date +%F_%R:%S): Uploading parsed data in $ES_FILE_NAME to $ES_URL."
curl -H 'Content-Type: application/x-ndjson' -XPOST $ES_URL --data-binary @$ES_FILE_NAME
echo "$(date +%F_%R:%S): Uploading is finished."

echo "---------=======----------"