# compile.ps1
# Generic Typst compilation script (zero business logic)
# Compiles any arbitrary .typ source file to PDF using the Typst CLI

param(
    [Parameter(Mandatory=$true)]
    [string]$TypstFile,

    [Parameter(Mandatory=$false)]
    [string]$OutputFile = "",

    [Parameter(Mandatory=$false)]
    [switch]$AutoInstall = $false
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $TypstFile)) {
    Write-Error "Source Typst file not found: $TypstFile"
}

$ResolvedTypstFile = (Resolve-Path $TypstFile).Path
$FileDir = Split-Path -Parent $ResolvedTypstFile
$FileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($ResolvedTypstFile)

if (-not $OutputFile) {
    $OutputFile = Join-Path $FileDir "$FileNameWithoutExt.pdf"
}
else {
    $OutDir = Split-Path -Parent $OutputFile
    if ($OutDir -and (-not (Test-Path $OutDir))) {
        New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
    }
    $OutputFile = [System.IO.Path]::GetFullPath($OutputFile)
}

# 1. Locate Typst executable
$TypstCmd = ""
if (Get-Command "typst" -ErrorAction SilentlyContinue) {
    $TypstCmd = "typst"
}
elseif ($env:LOCALAPPDATA) {
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WinGet\Packages"
    if (Test-Path $WingetPath) {
        $FoundTypst = Get-ChildItem -Path $WingetPath -Filter "typst.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
        if ($FoundTypst -and (Test-Path $FoundTypst)) {
            $TypstCmd = $FoundTypst
        }
    }
}

# 2. If not found, handle installation
if (-not $TypstCmd) {
    Write-Host ""
    Write-Host "Typst compiler was not found on your system."
    Write-Host "Typst is a fast, lightweight modern CLI markup compiler."
    
    if ($AutoInstall) {
        Write-Host "Attempting installation via Windows Package Manager (winget)..."
        & winget install -e --id Typst.Typst --accept-source-agreements --accept-package-agreements
        if (Get-Command "typst" -ErrorAction SilentlyContinue) {
            $TypstCmd = "typst"
        }
    }
    
    if (-not $TypstCmd) {
        Write-Host ""
        Write-Host "To install Typst, run:"
        Write-Host "    winget install -e --id Typst.Typst"
        Write-Host ""
        exit 1
    }
}

# 3. Compile document
Write-Host "Compiling Typst: $ResolvedTypstFile -> $OutputFile"
& $TypstCmd compile "$ResolvedTypstFile" "$OutputFile"

if ($LASTEXITCODE -eq 0 -and (Test-Path $OutputFile)) {
    Write-Host "Compilation successful: $OutputFile"
    exit 0
}
else {
    Write-Error "Typst compilation failed with exit code $LASTEXITCODE."
}
