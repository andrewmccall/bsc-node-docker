#!/bin/sh

# Loads the snapshot from a public GCS bucket and decompresses it as part of the
# startup process

echo "Mounting ${GCS_BUCKET}"
mkdir -p /mnt/gcs
gcsfuse $GCS_BUCKET /mnt/gcs

