#! /bin/bash

ROOT_DIR=$(dirname "$0")

set -a
source $ROOT_DIR/.env
set +a

if [ -f "$FOLDER/backup.sql" ]; then
    mv $FOLDER/backup.sql $FOLDER/backup.sql.old
fi

if [ -f "$FOLDER/trilium.tar.gz" ]; then
    mv $FOLDER/trilium.tar.gz $FOLDER/trilium.tar.gz.old
fi

if [ -f "$FOLDER/k3s.tar.gz" ]; then
    mv $FOLDER/k3s.tar.gz $FOLDER/k3s.tar.gz.old
fi

sh $ROOT_DIR/backup.sh $CP_IP ubuntu ~/.ssh/aws $BACKUP_DIR postgres
sh $ROOT_DIR/backup.sh $CP_IP ubuntu ~/.ssh/aws $BACKUP_DIR trilium
