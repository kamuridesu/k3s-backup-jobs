#! /bin/bash

backup_trilium() {
    echo "Creating trilium backup"
    cd /
    sudo tar -czvf trilium.tar.gz trilium-data
    sudo mv trilium.tar.gz $HOME/trilium.tar.gz
    cd -
}

backup_postgres() {
    echo "Creating postgres backup"
    sudo docker exec -u postgres postgres-postgres_primary-1 pg_dumpall > $HOME/backup.sql
}

backup_k3s_db() {
    echo "Creating k3s backup"
    cd $HOME
    sudo tar -czvf k3s.tar.gz /var/lib/rancher/k3s/server/db /var/lib/rancher/k3s/server/token
    cd -
}

if [[ "$1" = "trilium" ]]; then
    backup_trilium
elif [[ "$1" = "postgres" ]]; then
    backup_postgres
    backup_k3s_db
elif [[ "$1" = "" ]]; then
    backup_postgres
    backup_trilium
fi
