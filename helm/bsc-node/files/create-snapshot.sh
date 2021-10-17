#!/bin/sh

# tars up a geth node to create a snapshot in the same way that the bsc snapshots are generates. 

echo "Creating snapshot of ${GETH_DIR}/geth in ${SNAPSHOT_DIR}"

cd $GETH_DIR
tar -zcvf ${SNAPSHOT_DIR}${SNAPSHOT_FILE} geth/chaindata/* --transform='s|^|server/data-seed/|'
