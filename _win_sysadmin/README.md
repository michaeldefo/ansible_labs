###ansible_labs_win_sysadmin
###Handling my personnal ansible project learning and tools building For Windows administration tasks

Ansible Automation Windows System Administration Learning Project
Version in file _win_sysadmin/VERSION
This repository contains Ansible playbooks, roles, and configurations for automating Windows System Administration Task.

Structure
_win_sysadmin/playbooks/: Main playbooks to execute.
_win_sysadmin/roles/: Reusable roles for tasks.
_win_sysadmin/inventory/: Inventory files for different environments.
_win_sysadmin/group_vars/ and PRJ_NAME/host_vars/: Variable definitions.
_win_sysadmin/files/ and PRJ_NAME/templates/: Static files and Jinja2 templates.
Getting Started
To run a playbook:

ansible-playbook -i _win_sysadmin/inventory/windows_Hosts_inventory _win_sysadmin/playbooks/your_playbook.yml
