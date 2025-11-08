#!/bin/sh
# -----------------------------------------------------------------------------
# Name: gen_ansible_role_skel.sh
# Author: Michael D. (Linux adaptation)
# Version: 0.0.1
# Description: Initialise un squelette standard de rôle Ansible avec fichiers d'exemple.
# Usage: ./gen_ansible_role_skel.sh <base_path>
# -----------------------------------------------------------------------------

set -e
LOG_FILE="ansible_project_setup.log"
ROLLBACK_ACTIONS=()

# 📒 Journalisation
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# 🔁 Rollback en cas d'erreur
rollback() {
  log "Rolling back changes..."
  for (( idx=${#ROLLBACK_ACTIONS[@]}-1 ; idx>=0 ; idx-- )) ; do
    eval "${ROLLBACK_ACTIONS[$idx]}"
  done
  log "Rollback complete."
}

# 📁 Création de dossier
create_dir() {
  mkdir -p "$1"
  ROLLBACK_ACTIONS+=("rm -rf \"$1\"")
  log "Created directory: $1"
}

# 📄 Création de fichier
create_file() {
  echo "$2" > "$1"
  ROLLBACK_ACTIONS+=("rm -f \"$1\"")
  log "Created file: $1"
}

# 🚀 Initialisation du projet
initialize_project() {
  BASE_PATH="$1"
  if [[ -z "$BASE_PATH" ]]; then
    echo "❌ Usage: $0 <base_path>"
    exit 1
  fi

  if [[ ! -d "$BASE_PATH" ]]; then
    echo "❌ Le chemin de base '$BASE_PATH' est introuvable. Vérifiez les crochets ou les permissions."
    exit 1
  fi

  read -p "Enter your Ansible role name: " ROLE_NAME
  FULL_PATH="$BASE_PATH/$ROLE_NAME"
  echo "$FULL_PATH"

  trap rollback ERR

  create_dir "$FULL_PATH"
  cd "$FULL_PATH"

  create_dir "defaults"
  create_dir "meta"
  create_dir "tasks"
  create_dir "templates"

  create_file "tasks/main.yml" "--- 
# same for this linux version add usage line on comment
- name: Ensure NTP is installed
  package:
    name: ntp
    state: present"

  create_file "meta/main.yml" "---
galaxy_info:
  version: 0.0.1
  author: Michael D <dtmghislain@gmail.com>
  comment: Part of ansible_labs project for automating administration tasks script to generate template role on linux platforms
  repos_dev: https://github.com/michaeldefo/ansible_labs/tree/feature/install_k8s_cluster
  repos_main: https://github.com/michaeldefo/ansible_labs.git
  description: Deploy K8S Cluster playbook
  license: MIT
  min_ansible_version: 2.9"

  create_file "templates/ntp.conf.j2" "# NTP configuration template
server {{ ntp_server }}"

  log "Ansible project '$ROLE_NAME' has been created successfully."
}

initialize_project "$1"
