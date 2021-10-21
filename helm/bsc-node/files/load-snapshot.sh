#!/bin/sh

set -e
echo "Runing init checks and config for BSC node."

# Loads the snapshot from a public GCS bucket and decompresses it as part of the
# startup process. Assumes the tar is in the same format that BSC snapshots.

# If DATA_DIRECTORY has stuff in it, then just return we don't need to do anything. 
if [ ! -z "$(ls -A ${GETH_DATA_DIRECTORY})" ]; then
   echo "Data [${GETH_DATA_DIRECTORY}] is not empty, nothing to do"
   sleep 1000
   return 0
fi

echo "Copying snapshot gs://${SNAPSHOT_BUCKET}/${SNAPSHOT_FILE} to ${SNAPSHOT_TEMP_DIRECTORY}"
# first let's get the data
gsutil cp gs://${SNAPSHOT_BUCKET}/${SNAPSHOT_FILE} ${SNAPSHOT_TEMP_DIRECTORY}

echo "Init the data dir ${GETH_DATA_DIRECTORY}"
/opt/geth/bin/geth init --datadir ${GETH_DATA_DIRECTORY} ${GETH_CONFIG_DIRECTORY}/genesis.json

echo "Extracting ${SNAPSHOT_FILE}"
tar -zxvf ${SNAPSHOT_TEMP_DIRECTORY}/${SNAPSHOT_FILE} -C ${GETH_DATA_DIRECTORY} --strip-components=2

echo $(find .)
