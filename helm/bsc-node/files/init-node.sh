#!/bin/sh

set -e
echo "Runing init checks and config for BSC node."

# Loads the snapshot from a public GCS bucket and decompresses it as part of the
# startup process. Assumes the tar is in the same format that BSC snapshots.

# If DATA_DIRECTORY/init.success exists, then just return we don't need to do anything. 
if [ -f "${GETH_DATA_DIRECTORY}/init.success" ]; then
   echo "Data [${GETH_DATA_DIRECTORY}] init.success exists, nothing to do"
   return 0
fi

# kubectl create the temp PVC if it doesn't exist. 

kubectl apply -f ./temp-pvc -n $MY_POD_NAMESPACE 
echo "Created temp PVC"

# kubectl launch the job

kubclt apply -f ./job.yml -n $MY_POD_NAMESPACE
echo "Created Job."

#wait for finish... check the output.. fail init if the job fails.
kubectl wait --for=condition=complete job/myjob & completion_pid=$!
kubectl wait --for=condition=failed job/myjob && exit 1 & failure_pid=$! 

echo "Waiting for finish."
wait -n $completion_pid $failure_pid

exit_code=$?

if (( $exit_code == 0 )); then
  echo "Job completed"
else
  echo "Job failed with exit code ${exit_code}, exiting..."
fi

exit $exit_code

# Finally, if we've got this far let's create the init.success file so we don't 
# have to do any of that anymore. 

touch ${GETH_DATA_DIRECTORY}/init.success
echo "Created ${GETH_DATA_DIRECTORY}/init.success -- all done."
