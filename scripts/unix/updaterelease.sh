#!/bin/bash
# -----------------------------------------------------------------------------
# Name: updaterelease.sh
# Author: Michael D. (Linux adaptation)
# Version: 0.0.1
# Description: Alimente un fichier RELEASE_NOTES.md à la racine du projet Git
# Usage: ./updaterelease.sh <version> <description> <author>
# -----------------------------------------------------------------------------

VERSION="$1"
DESCRIPTION="$2"
AUTHOR="$3"
NOTES_FILE_NAME="RELEASE_NOTES.md"

# 🧪 Vérification des paramètres
if [[ -z "$VERSION" || -z "$DESCRIPTION" || -z "$AUTHOR" ]]; then
  echo "❌ Usage: $0 <version> <description> <author>"
  exit 1
fi

# 📅 Date du jour
DATE=$(date +%Y-%m-%d)
NEW_LINE="| $VERSION | $DATE | $AUTHOR | $DESCRIPTION |"

# 🔍 Racine du projet Git
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [[ -z "$GIT_ROOT" ]]; then
  echo "❌ Impossible de localiser la racine du projet Git."
  exit 1
fi

# 📍 Vérifier existence locale
LOCAL_EXISTS=$(git tag | grep -Fx "$VERSION")
# 📍 Vérifier existence distante
REMOTE_EXISTS=$(git ls-remote --tags origin | awk -F'/' '{print $NF}' | sed 's/\^{}//' | grep -Fx "$VERSION")

# 🧱 Si le tag existe
if [[ -n "$LOCAL_EXISTS" && -n "$REMOTE_EXISTS" ]]; then
  echo "❌ Le tag '$VERSION' existe déjà localement et sur le dépôt distant."
  echo "⛔ Annulation de l'opération."
  exit 1
elif [[ -n "$LOCAL_EXISTS" ]]; then
  echo "❌ Le tag '$VERSION' existe déjà localement."
  echo "⛔ Annulation de l'opération."
  exit 1
elif [[ -n "$REMOTE_EXISTS" ]]; then
  echo "❌ Le tag '$VERSION' existe déjà sur le dépôt distant."
  echo "⛔ Annulation de l'opération."
  exit 1
fi

# 📁 Chemin complet vers le fichier de release notes
NOTES_FILE="$GIT_ROOT/$NOTES_FILE_NAME"

# 🧱 Initialiser le fichier si nécessaire
if [[ ! -f "$NOTES_FILE" ]]; then
  echo "# 📦 Historique des versions — gen_ansible_role_skel.sh" > "$NOTES_FILE"
  echo "> 🛠️ Ce fichier est mis à jour automatiquement par le script \`updaterelease.sh\`. Ne pas modifier manuellement." >> "$NOTES_FILE"
  echo "| Version | Date | Auteur | Description |" >> "$NOTES_FILE"
  echo "|---------|------------|--------|-------------|" >> "$NOTES_FILE"
fi

# ➕ Ajouter la nouvelle ligne
echo "$NEW_LINE" >> "$NOTES_FILE"
echo "✅ Release note ajoutée à $NOTES_FILE"

# 🏷️ Créer le tag Git
TAG_MESSAGE="release: $VERSION | $DESCRIPTION"
git tag -a "$VERSION" -m "$TAG_MESSAGE"
echo "🏷️ Tag Git '$VERSION' créé avec message : $TAG_MESSAGE"
