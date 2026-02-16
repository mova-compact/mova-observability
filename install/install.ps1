$ErrorActionPreference = "Stop"

$Repo = "mova-compact/mova-downloads"
$Asset = "mova-compact.exe"
$Url = "https://github.com/$Repo/releases/latest/download/$Asset"
$InstallDir = "$env:LOCALAPPDATA\mova-compact"

Write-Host "Downloading MOVA Compact for Windows..."
New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
Invoke-WebRequest -Uri $Url -OutFile (Join-Path $InstallDir $Asset)

$ExePath = Join-Path $InstallDir "mova-compact.exe"
if (-not (Test-Path $ExePath)) {
    Write-Error "Installation failed: mova-compact.exe not found"
    exit 1
}

# Add to user PATH if not already there
$UserPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($UserPath -notlike "*$InstallDir*") {
    [Environment]::SetEnvironmentVariable("PATH", "$UserPath;$InstallDir", "User")
    Write-Host "Added $InstallDir to user PATH (restart terminal to apply)."
}

Write-Host "Verifying..."
& $ExePath --version

Write-Host "MOVA Compact installed successfully."
