$ErrorActionPreference = "Stop"

$Binary = if ($args.Count -gt 0) { $args[0] } else {
    $DefaultPath = Join-Path $env:LOCALAPPDATA "mova-compact\mova-compact.exe"
    if (Test-Path $DefaultPath) { $DefaultPath }
    else { Get-Command mova-compact.exe -ErrorAction Stop | Select-Object -ExpandProperty Source }
}

if (-not (Test-Path $Binary)) {
    Write-Error "mova-compact binary not found at: $Binary"
    exit 1
}

Write-Host "Binary: $Binary"
$Hash = (Get-FileHash $Binary -Algorithm SHA256).Hash
Write-Host "SHA256: $Hash"

Write-Host ""
Write-Host "Compare against official checksums at:"
Write-Host "  https://github.com/mova-compact/mova-downloads/releases/latest/download/SHA256SUMS.txt"
Write-Host ""
Write-Host "Verification complete."
