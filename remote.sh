#! /bin/bash

backup_trilium() {
    echo "Creating trilium backup"
    cd /
    sudo tar -czvf trilium.tar.gz trilium
    sudo mv trilium.tar.gz $HOME/trilium.tar.gz
    cd -
}

backup_postgres() {
    echo "Creating postgres backup"
    sudo docker exec -u postgres postgres-postgres_primary-1 pg_dumpall > $HOME/backup.sql
}

if [[ "$1" = "trilium" ]]; then
    backup_trilium
elif [[ "$1" = "postgres" ]]; then
    backup_postgres
elif [[ "$1" = "" ]]; then
    backup_postgres
    backup_trilium
fi
