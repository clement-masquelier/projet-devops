#!/bin/bash

# Définition des variables
KEY_PATH="ssh_keys/k3s_ansible_key"
CLOUD_CONFIG_FILE="cloud-config.yaml"

echo "Démarrage de la configuration de l'infrastructure..."

# Création du répertoire pour les clés SSH s'il n'existe pas
mkdir -p "$(dirname "$KEY_PATH")"

# Génération de la clé SSH (si elle n'existe pas déjà)
if [ ! -f "$KEY_PATH" ]; then
    echo "Création d'une nouvelle paire de clés SSH..."
    ssh-keygen -t ed25519 -f "$KEY_PATH" -q -N "" -C "ansible-k3s-runner"
else
    echo "La clé SSH existe déjà ($KEY_PATH)."
fi

# Récupération de la clé publique
PUB_KEY=$(cat "${KEY_PATH}.pub")

echo "Fichier $CLOUD_CONFIG_FILE généré avec succès !"