# -----------------------------------------------------------------------------
# Name: updaterelease.ps1
# Author: Michael D. (Windows adaptation)
# Version: 0.0.1
# Description: Alimentation d'un fichier RELEASE_NOTES.md global au projet
# Usage: .\updaterelease.ps1
# -----------------------------------------------------------------------------

param (
    [Parameter(Mandatory=$true)][string]$Version,
    [Parameter(Mandatory=$true)][string]$Description,
    [Parameter(Mandatory=$true)][string]$Author,
    [string]$NotesFileName = "RELEASE_NOTES.md"
)

$Date = Get-Date -Format "yyyy-MM-dd"
$NewLine = "| $Version | $Date | $Author | $Description |"

# 🔍 Trouver la racine du projet Git
$GitRoot = git rev-parse --show-toplevel
if (-not $GitRoot) {
    throw "❌ Impossible de localiser la racine du projet Git."
}

#🏷️ Vérifier si le TAG existe déjà en Local ou en Remote
$localTags = git tag
$remoteTags = git ls-remote --tags origin | ForEach-Object { ($_ -split "/")[-1] -replace "\^{}","" }

if ($localTags -contains $Version -and $remoteTags -contains $Version) {
    Write-Warning "❌ Le tag '$Version' existe déjà localement et sur le dépôt distant."
    return
}
elseif ($localTags -contains $Version) {
    Write-Warning "❌ Le tag '$Version' existe déjà localement."
    return
}
elseif ($remoteTags -contains $Version) {
    Write-Warning "❌ Le tag '$Version' existe déjà sur le dépôt distant."
    return
}


# 📁 Chemin complet vers le fichier de release notes
$NotesFile = Join-Path -Path $GitRoot -ChildPath $NotesFileName

# 🧱 Initialiser le fichier si nécessaire
#if (-not (Test-Path -LiteralPath $NotesFile)) {
    #"# 📦 Historique des versions — gen_ansible_role_skel.ps1`n" | Out-File $NotesFile
#    "# Historique des versions — gen_ansible_role_skel.ps1`n" | Out-File $NotesFile
#    "| Version | Date | Auteur | Description |`n|---------|------------|--------|-------------|" | Out-File $NotesFile -Append
#

if (-not (Test-Path -LiteralPath $NotesFile)) {
@"
    # 📦 Historique des versions — gen_ansible_role_skel.ps1
    > 🛠️ Ce fichier est mis à jour automatiquement par le script `updaterelease.ps1`. Ne pas modifier manuellement.
    | Version | Date       | Auteur      | Description |
    |---------|------------|-------------|-------------|
"@ | Out-File -FilePath $NotesFile -Encoding UTF8
}

# ➕ Ajouter la nouvelle ligne
Add-Content -LiteralPath $NotesFile -Value $NewLine
Write-Output "✅ Release note ajoutée à $NotesFile"

# 🏷️ Créer le tag Git
$TagMessage = "release: $Version | $Description"
git tag -a $Version -m "$TagMessage"
Write-Output "🏷️ Tag Git '$Version' créé avec message : $TagMessage"

