# init-profile.ps1
# Initializes the candidate profile from template if it does not exist

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DomainRoot = Split-Path -Parent $ScriptDir
$DataDir = Join-Path $DomainRoot "data"
$TemplatesDir = Join-Path $DomainRoot "templates"

if (-not (Test-Path $DataDir)) {
    New-Item -ItemType Directory -Path $DataDir | Out-Null
}

$TemplateFile = Join-Path $TemplatesDir "candidate-profile.template.yaml"
$TargetFile = Join-Path $DataDir "candidate-profile.yaml"

if (Test-Path $TargetFile) {
    Write-Host "Candidate profile already exists at: $TargetFile"
}
else {
    Copy-Item -Path $TemplateFile -Destination $TargetFile
    Write-Host "Candidate profile initialized from template at: $TargetFile"
    Write-Host "Please edit candidate-profile.yaml to reflect your authentic experience and skills."
}

$StoriesTemplate = Join-Path $TemplatesDir "star-stories.template.md"
$StoriesTarget = Join-Path $DataDir "star-stories.md"

if (Test-Path $StoriesTarget) {
    Write-Host "STAR stories bank already exists at: $StoriesTarget"
}
else {
    Copy-Item -Path $StoriesTemplate -Destination $StoriesTarget
    Write-Host "STAR stories bank initialized from template at: $StoriesTarget"
}

$AppsTemplate = Join-Path $TemplatesDir "applications.template.csv"
$AppsTarget = Join-Path $DataDir "applications.csv"

if (Test-Path $AppsTarget) {
    Write-Host "Applications CSV already exists at: $AppsTarget"
}
else {
    Copy-Item -Path $AppsTemplate -Destination $AppsTarget
    Write-Host "Applications CSV initialized from template at: $AppsTarget"
}
