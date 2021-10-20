#bsc-node

This repo contains the Dockerfiles and helm charts required to bring up a Binance Smart Chain node on GKE. 


## Setup. 

We have the data stored in a cloud bucket, we need to get it onto a temp PVC. It probably would have been OK
to just run up an init container with the temp PVC. First, get the init container running. 

Do the below if the data dir does not exist. 

1) Copy the data to the temp PCV and mount it somewhere. 
2) run the init to create the right data dirs for the node
3) Unzip the file where it needs to go. 

Return 0. 

Go back and remove the init container and PCV. Ideally we'd create the temp PVC programatically... 

```
# ssd-claim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: bsc-node-temp
spec:
  storageClassName: premium-rwo
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 700Gi
```