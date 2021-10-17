#!/bin/sh

set -e

# Loads the snapshot from a public GCS bucket and decompresses it as part of the
# startup process. Assumes the tar is in the same format that BSC snapshots.

RUN /opt/geth/bin/geth init --datadir /opt/geth/node /opt/geth/config/genesis.json

gsutil cp gs://crypto-bsc-snapshots/${SNAPSHOT_FILE} /opt/geth/node/
 
echo "Extracting ${SNAPSHOT_FILE}"
tar -zxvf /opt/geth/node/{SNAPSHOT_FILE} -C ${OUTPUT_LOCATION} --strip-components=2
