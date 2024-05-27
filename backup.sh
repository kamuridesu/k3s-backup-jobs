if [ "$1" == "" ]; then
    echo "Faltando IP de destino"
    exit 1
fi

if [ "$2" == "" ]; then
    echo "Faltando nome de usuario"
    exit 1
fi

if [ "$3" == "" ]; then
    echo "Faltando chave SSH"
    exit 1
fi

if [ ! -f "$3" ]; then
    echo "Chave SSH não encontrada"
    exit 1
fi

if [ "$4" == "" ]; then
    echo "Faltando pasta de destino"
    exit 1
fi

DEST_IP="$1"
USER="$2"
SSH_KEY="$3"
FOLDER="$4"
KIND="$5"

mkdir -p $FOLDER

SCP_COMMAND="scp -i $SSH_KEY"
SSH_COMMAND="ssh -i $SSH_KEY $USER@$DEST_IP"

setup_backup() {
    sh -c "$SCP_COMMAND remote.sh $USER@$DEST_IP:/home/$USER/remote.sh"
    sh -c "$SSH_COMMAND bash /home/$USER/remote.sh $KIND"
}

backup_trilium() {
    echo "Backing up trilium..."
    sh -c "$SCP_COMMAND $USER@$DEST_IP:/home/$USER/trilium.tar.gz $FOLDER/trilium.tar.gz"
}

backup_postgres() {
    echo "Backing up postgres..."
    sh -c "$SCP_COMMAND $USER@$DEST_IP:/home/$USER/backup.sql $FOLDER/backup.sql"
}

setup() {
    echo "Setting up..."
    setup_backup
    
    if [[ "$KIND" != "" ]]; then
        if [[ "$KIND" == "postgres" ]]; then
            backup_postgres
        elif [[ "$KIND" == "trilium" ]]; then
            backup_trilium
        else
            echo "Nothing to do"
        fi
    else
        backup_postgres
        backup_trilium
    fi
    echo "Done!"
}

setup
