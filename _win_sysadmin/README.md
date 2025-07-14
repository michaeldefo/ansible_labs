### ansible_labs_win_sysadmin

### Handling my personal Ansible project for learning and building tools for Windows administration tasks
# Ansible Automation Windows System Administration Learning Project
# Version in file _win_sysadmin/VERSION
This repository contains Ansible playbooks, roles, and configurations for automating Windows System Administration tasks.

## Structure
- _win_sysadmin/playbooks/: Main playbooks to execute.
- _win_sysadmin/roles/: Reusable roles for tasks.
- _win_sysadmin/inventory/: Inventory files for different environments.
- _win_sysadmin/group_vars/ and _win_sysadmin/host_vars/: Variable definitions.
- _win_sysadmin/files/ and _win_sysadmin/templates/: Static files and Jinja2 templates.

# Getting Started
To run a playbook:

```bash
ansible-playbook -i _win_sysadmin/inventory/windows_Hosts_inventory _win_sysadmin/playbooks/your_playbook.yml
