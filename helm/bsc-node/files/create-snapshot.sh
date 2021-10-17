#!/bin/sh

# tars up a geth node to create a snapshot in the same way that the bsc snapshots are generates. 

$BASE_DIR
$OUTPUT_LOCATION

tar -zcvf snapshot.tar.gz geth/