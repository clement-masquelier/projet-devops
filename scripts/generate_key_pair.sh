#!/bin/bash

# Définition des variables
KEY_PATH=".ssh_keys/vagrant_k3s_key"
CLOUD_CONFIG_FILE="cloud-config.yaml"

echo "Démarrage de la configuration de l'infrastructure..."

# Création du répertoire pour les clés SSH s'il n'existe pas
mkdir -p "$(dirname "$KEY_PATH")"

# 1. Génération de la clé SSH (si elle n'existe pas déjà)
if [ ! -f "$KEY_PATH" ]; then
    echo "Création d'une nouvelle paire de clés SSH..."
    # -t: type, -f: chemin, -q: silencieux, -N "": pas de mot de passe
    ssh-keygen -t ed25519 -f "$KEY_PATH" -q -N "" -C "ansible-k3s-runner"
else
    echo "La clé SSH existe déjà ($KEY_PATH)."
fi

# 2. Récupération de la clé publique
PUB_KEY=$(cat "${KEY_PATH}.pub")

# 3. Création du fichier cloud-config.yaml avec la clé injectée
echo "Génération du fichier $CLOUD_CONFIG_FILE..."

cat <<EOF > $CLOUD_CONFIG_FILE
#cloud-config
users:
  - default
  - name: vagrant
    ssh_authorized_keys:
      - "$PUB_KEY"
EOF

echo "Fichier $CLOUD_CONFIG_FILE généré avec succès !"