###ansible_labs
###Handling my personnal ansible project learning and tools building....

# Ansible Project
# version 0
This repository contains Ansible playbooks, roles, and configurations for automating infrastructure and application deployments.

## Structure

- `PRJ_NAME/playbooks/`: Main playbooks to execute.
- `PRJ_NAME/roles/`: Reusable roles for tasks.
- `PRJ_NAME/inventory/`: Inventory files for different environments.
- `PRJ_NAME/group_vars/` and `PRJ_NAME/host_vars/`: Variable definitions.
- `PRJ_NAME/files/` and `PRJ_NAME/templates/`: Static files and Jinja2 templates.

## Getting Started

To run a playbook:

```bash
ansible-playbook -i PRJ_NAME/inventory/your_inventory PRJ_NAME/playbooks/your_playbook.yml

