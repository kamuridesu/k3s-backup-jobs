#! /bin/bash

ROOT_DIR=$(dirname "$0")

set -a
source $ROOT_DIR/.env
set +a

sh $ROOT_DIR/backup.sh $CP_IP ubuntu ~/.ssh/aws $BACKUP_DIR postgres
sh $ROOT_DIR/backup.sh $WORKER_IP ubuntu ~/.ssh/aws $BACKUP_DIR trilium
