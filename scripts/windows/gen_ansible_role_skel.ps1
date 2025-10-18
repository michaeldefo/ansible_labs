# -----------------------------------------------------------------------------
# Name: gen_ansible_role_skel.ps1
# Author: Michael D. (Windows adaptation)
# Version: 0.0.1
# Description: Initializes a standard Ansible role structure with example files.
# Usage: .\gen_ansible_role_skel.ps1 -RolePathName "RolePathName"
# -----------------------------------------------------------------------------

################ Initialize role path name Value
param (
    [Parameter(Mandatory = $true)]
    [string]$RolePathName
)

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
        $RoleName = Read-Host "Enter your Ansible role name"
        
        #Set Path name to generate template dir role
        $fullPath = Join-Path -Path $RolePathName -ChildPath $RoleName
        Write-Output $fullPath
        
        ##### Create role 
        Get-Directory $fullPath
        # Testing role dir path creation 
        if (-not (Test-Path -LiteralPath $RolePathName)) {
           throw "❌ Le chemin de base '$RolePathName' est introuvable. Vérifiez les crochets ou les permissions."
        }

        #Set-Location $fullPath using LiteralPath
        Set-Location -LiteralPath $fullPath
        
        Get-Directory "defaults"
        Get-Directory "meta"
        Get-Directory "tasks"
        Get-Directory "templates"

        Get-File "tasks\main.yml" "--- 
# same for this windows version add usage line on comment
- name: Ensure NTP is installed
  package:
    name: ntp
    state: present"

        Get-File "meta\main.yml" "---
  galaxy_info:
  version: 0.0.1
  author: Michael D <dtmghislain@gmail.com>
  comment: Part of ansible_labs project for automating administration tasks script to generate template role on windows platforms
  repos_dev: https://github.com/michaeldefo/ansible_labs/tree/feature/install_k8s_cluster - branch for DEV
  repos_main: https://github.com/michaeldefo/ansible_labs.git to commit on global repos
  description: Deploy K8S Cluster playbook
  license: MIT
  min_ansible_version: 2.9"

        Get-File "templates\ntp.conf.j2" "# NTP configuration template
server {{ ntp_server }}"

        Log "Ansible project '$RoleName' has been created successfully."
    }
    catch {
        Log "Error occurred: $_"
        Rollback
    }
}

Initialize-Project
