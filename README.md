### Handling my personnal ansible project learning and tools building

## Ansible Automation Learning Project

# Looks For Version in VERSION File

#### With `markdown-include` (Python):

[INCLUDE ../version]

# Informations

This repository contains Ansible playbo**o**ks, roles, and configurations for automating infrastructure and application deployments.

# To use ansible vscode plugin for code completion and syntax check

- We Create an ansible_env for python library `cd $ANSIBLE_LABS_PRJ && python -m venv ansible-env`
- We Activate it `ansible-env\Scripts\activate.bat`
- We Install then ansible-dev `python -m pip install ansible-dev-tools ansible-core`
- We install ansible plugin on vs code

## Structure

- `PRJ_NAME/playbooks/`: Main playbooks to execute.
- `PRJ_NAME/playbooks/roles/`: Reusable roles for tasks.
- `PRJ_NAME/inventory/`: Inventory files for different environments.
- `PRJ_NAME/group_vars/` and `PRJ_NAME/host_vars/`: Variable definitions.
- `PRJ_NAME/files/` and `PRJ_NAME/templates/`: Static files and Jinja2 templates.

## Generate a Project structure on a new empty directory on windows or linux platform

- clone project
- `cd scripts/{windows|unix}`
- `cp gen_ansible_prj_skel.{ps1|sh} {new_workdir}`
- `cd {new_workdir}`
- `./gen_ansible_prj_skel.{ps1|sh}`

## Generate role dir template do create a new role for project on windows platform

- clone project
- `cd scripts/windows`
- `./gen_ansible_role_skel.ps1 -RolePathName "RolePathName"`
- RolePathname like PRJ\_{nix|win}_sysadmin\playbooks\roles at the prompt enter your's role name

## Generate role dir template do create a new role for project on linux platform

- clone project
- `cd scripts/unix`
- `./gen_ansible_role_skel.sh "RolePathName"`
- RolePathname like PRJ/_{nix|win}_sysadmin/playbooks/roles at the prompt enter your's role name

## After adding a new feature to a project we have a script to update the RELEASE_NOTES.md file and add the equivalent TAG for the git feature for windows or linux

- `git checkout -b feature/{myFeature}`
----- Implement my feature Then update the release file
- `cd scripts/{windows|unix}`
- WIN : `.\updaterelease.ps1 -Version "xxx" -Description "xxxxx" -Author "xxxx"`
- UNIX:  `./updaterelease.sh "version" "description" "author"`

## Getting Started

To run a playbook:

```bash
ansible-playbook -i PRJ_NAME/inventory/your_inventory PRJ_NAME/playbooks/your_playbook.yml



[def]: VERSION