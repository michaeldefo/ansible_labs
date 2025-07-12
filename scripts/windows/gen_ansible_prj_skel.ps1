# -----------------------------------------------------------------------------
# Name: gen_ansible_prj_skel.ps1
# Author: Michael D. (Windows adaptation)
# Version: 0.0.1
# Description: Initializes a standard Ansible project structure with example files.
# Usage: .\gen_ansible_prj_skel.ps1
# -----------------------------------------------------------------------------

$ErrorActionPreference = "Stop"
$LogFile = "ansible_project_setup.log"
$RollbackActions = @()

function Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Tee-Object -FilePath $LogFile -Append
}

function Rollback {
    Log "Rolling back changes..."
    for ($i = $RollbackActions.Count - 1; $i -ge 0; $i--) {
        Invoke-Expression $RollbackActions[$i]
    }
    Log "Rollback complete."
}

function Get-File {
    param (
        [string]$Path,
        [string]$Content
    )
    $Content | Out-File -FilePath $Path -Encoding UTF8
    $RollbackActions += "Remove-Item -Force '$Path'"
    Log "Created file: $Path"
}

function Get-Directory {
    param ([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    $RollbackActions += "Remove-Item -Recurse -Force '$Path'"
    Log "Created directory: $Path"
}

function Initialize-Project {
    try {
        $ProjectName = Read-Host "Enter your Ansible project name"

        Get-Directory $ProjectName
        Set-Location $ProjectName

        Get-Directory "inventory"
        Get-Directory "playbooks"
        Get-Directory "roles\common\tasks"
        Get-Directory "group_vars"
        Get-Directory "host_vars"
        Get-Directory "templates"

        Get-Directory "README.md" "# $ProjectName

This is an Ansible project initialized with a standard structure.
Each directory contains example files to help you get started."

        Get-File "ansible.cfg" "[defaults]
inventory = ./inventory/hosts.ini
roles_path = ./roles"

        Get-File "inventory\hosts.ini" "[local]
localhost ansible_connection=local"

        Get-File "playbooks\site.yml" "--- 
- name: Example playbook
  hosts: all
  become: yes
  roles:
    - common"

        Get-File "roles\common\tasks\main.yml" "--- 
# same for this windows version add usage line on comment
- name: Ensure NTP is installed
  package:
    name: ntp
    state: present"

        Get-File "group_vars\all.yml" "--- 
ntp_server: pool.ntp.org"

        Get-File "host_vars\localhost.yml" "--- 
timezone: UTC"

        Get-File "templates\ntp.conf.j2" "# NTP configuration template
server {{ ntp_server }}"

        Log "Ansible project '$ProjectName' has been created successfully."
    }
    catch {
        Log "Error occurred: $_"
        Rollback
    }
}

Initialize-Project
