# compile-typst.ps1
# Backward-compatibility wrapper forwarding to skills/typst-pdf/scripts/compile.ps1

param(
    [Parameter(Mandatory=$true)]
    [string]$TypstFile,

    [Parameter(Mandatory=$false)]
    [string]$OutputFile = "",

    [Parameter(Mandatory=$false)]
    [switch]$AutoInstall = $false
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$CompileScript = Join-Path $ScriptDir "..\skills\typst-pdf\scripts\compile.ps1"

if (-not (Test-Path $CompileScript)) {
    Write-Error "Generic compile.ps1 not found at: $CompileScript"
}

$Params = @{
    TypstFile = $TypstFile
}

if ($OutputFile) {
    $Params["OutputFile"] = $OutputFile
}

if ($AutoInstall) {
    $Params["AutoInstall"] = $true
}

& powershell -ExecutionPolicy Bypass -File "$CompileScript" @Params
exit $LASTEXITCODE
