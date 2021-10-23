#!/bin/sh

# This script will download and install the snapshot. It creates
# a PVC and a Job to perform the download. This allows us to resume 
# the download if the job fails but removed the PVC once we're done. 

echo "Copying snapshot gs://${SNAPSHOT_BUCKET}/${SNAPSHOT_FILE} to ${SNAPSHOT_TEMP_DIRECTORY}"
# first let's get the data
gsutil cp gs://${SNAPSHOT_BUCKET}/${SNAPSHOT_FILE} ${SNAPSHOT_TEMP_DIRECTORY}

echo "Init the data dir ${GETH_DATA_DIRECTORY}"
/opt/geth/bin/geth init --datadir ${GETH_DATA_DIRECTORY} ${GETH_CONFIG_DIRECTORY}/genesis.json

echo "Extracting ${SNAPSHOT_FILE}"
tar -zxvf ${SNAPSHOT_TEMP_DIRECTORY}/${SNAPSHOT_FILE} -C ${GETH_DATA_DIRECTORY} --strip-components=2