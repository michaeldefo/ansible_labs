# -----------------------------------------------------------------------------
# Name: prj_versionning.ps1
# Author: Michael D. (adapted for Windows)
# Version: 0.0.1
# Description: This script helps with semantic versioning of a project.
# Usage: .\prj_versionning.ps1 major|minor|patch
# -----------------------------------------------------------------------------

param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("major", "minor", "patch")]
    [string]$Type
)

$versionFile = "VERSION"

if (-Not (Test-Path $versionFile)) {
    "0.0.0" | Out-File -Encoding UTF8 $versionFile
}

$version = Get-Content $versionFile
$parts = $version -split '\.'

switch ($Type) {
    "major" {
        $parts[0] = [int]$parts[0] + 1
        $parts[1] = 0
        $parts[2] = 0
    }
    "minor" {
        $parts[1] = [int]$parts[1] + 1
        $parts[2] = 0
    }
    "patch" {
        $parts[2] = [int]$parts[2] + 1
    }
}

$newVersion = "$($parts[0]).$($parts[1]).$($parts[2])"
$newVersion | Out-File -Encoding UTF8 $versionFile
Write-Output "Version bumped to $newVersion"
