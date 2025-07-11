###ansible_labs
###Handling my personnal ansible project learning and tools building....

# Ansible Project

This repository contains Ansible playbooks, roles, and configurations for automating infrastructure and application deployments.

## Structure

- `playbooks/`: Main playbooks to execute.
- `roles/`: Reusable roles for tasks.
- `inventory/`: Inventory files for different environments.
- `group_vars/` and `host_vars/`: Variable definitions.
- `files/` and `templates/`: Static files and Jinja2 templates.

## Getting Started

To run a playbook:

```bash
ansible-playbook -i inventory/your_inventory playbooks/your_playbook.yml

