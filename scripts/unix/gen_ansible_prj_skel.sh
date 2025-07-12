#!/bin/bash

# -----------------------------------------------------------------------------
# Name: gen_ansible_prj_skel.sh
# Author: Michael D.
# Version: 0.0.1
# Description: Initializes a standard Ansible project structure with example files. 
#              This version is for Unix like system
#              Here a projet is a directory handling ansible stuff for specifics tasks
#              Dabatase Administration, System Administration, MyApp Deployment, Security
# Usage: .\gen_ansible_prj_skel.sh
# -----------------------------------------------------------------------------

set -e

# Global variables
LOG_FILE="ansible_project_setup.log"
ROLLBACK_ACTIONS=()

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

rollback() {
    log "Rolling back changes..."
    for (( idx=${#ROLLBACK_ACTIONS[@]}-1 ; idx>=0 ; idx-- )) ; do
        eval "${ROLLBACK_ACTIONS[idx]}"
    done
    log "Rollback complete."
}

create_file() {
    local file_path="$1"
    local content="$2"
    echo "$content" > "$file_path"
    ROLLBACK_ACTIONS+=("rm -f '$file_path'")
    log "Created file: $file_path"
}

create_directory() {
    local dir_path="$1"
    mkdir -p "$dir_path"
    ROLLBACK_ACTIONS+=("rm -rf '$dir_path'")
    log "Created directory: $dir_path"
}

initialize_project() {
    read -p "Enter your Ansible project name: " PROJECT_NAME

    trap rollback ERR

    create_directory "$PROJECT_NAME"
    cd "$PROJECT_NAME" || exit

    create_directory "inventory"
    create_directory "playbooks"
	create_directory "roles"
	create_directory "roles/common"
    create_directory "roles/common/tasks"
    create_directory "group_vars"
    create_directory "host_vars"
    create_directory "templates"

    create_file "README.md" "# $PROJECT_NAME

This is an Ansible project initialized with a standard structure.
Each directory contains example files to help you get started."

    create_file "ansible.cfg" "[defaults]
inventory = ./inventory/hosts.ini
roles_path = ./roles"

    create_file "inventory/hosts.ini" "[local]
localhost ansible_connection=local"

    create_file "playbooks/site.yml" "--- 
- name: Example playbook
  hosts: all
  become: yes
  roles:
    - common"

    create_file "roles/common/tasks/main.yml" "--- 
- name: Ensure NTP is installed
  package:
    name: ntp
    state: present"

    create_file "group_vars/all.yml" "--- 
ntp_server: pool.ntp.org"

    create_file "host_vars/localhost.yml" "--- 
timezone: UTC"

    create_file "templates/ntp.conf.j2" "# NTP configuration template
server {{ ntp_server }}"

    log "Ansible project '$PROJECT_NAME' has been created successfully."
}

initialize_project
