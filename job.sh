#! /bin/bash

set -a
source .env
set +a

sh backup.sh $CP_IP ubuntu ~/.ssh/aws ./backup postgres
sh backup.sh $WORKER_IP ubuntu ~/.ssh/aws ./backup trilium
