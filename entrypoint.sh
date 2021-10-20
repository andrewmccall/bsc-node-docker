#!/bin/sh

set -i -e
# This file runs the bsc node. 

# If DATA_DIRECTORY has stuff in it, then just return we don't need to do anything. 
if [ -z "$(ls -A ${GETH_DATA_DIRECTORY})" ]; then
   echo "Running init in ${GETH_DATA_DIRECTORY}"
   /opt/geth/bin/geth init --datadir ${GETH_DATA_DIRECTORY} ${GETH_CONFIG_DIRECTORY}/genesis.json
fi

echo "Starting geth..."
GETH_COMMAND="/opt/geth/bin/geth --config ${GETH_CONFIG_DIRECTORY}/config.toml --datadir ${GETH_DATA_DIRECTORY}/ --cache 18000 --rpc.allow-unprotected-txs --txlookuplimit 0 --ws --ipcdisable --metrics --metrics.addr=0.0.0.0 --verbosity 4"

nohup $GETH_COMMAND &

echo "Geth started."
# Wait a couple of seconds for the bsc.log to show up.
sleep 2 

# tail the log forever
tail -F ${GETH_DATA_DIRECTORY}/bsc.log
