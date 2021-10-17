#!/bin/sh


# Loads the snapshot from a public GCS bucket and decompresses it as part of the
# startup process. Assumes the tar is in the same format that BSC snapshots.

echo "Mounting ${GCS_BUCKET}"
mkdir -p ${SNAPSHOT_DIR}
#gcsfuse $GCS_BUCKET ${SNAPSHOT_DIR}

echo "Extracting ${SNAPSHOT_FILE}"
tar -zxvf ${SNAPSHOT_DIR}${SNAPSHOT_FILE} -C ${OUTPUT_LOCATION} --strip-components=2
