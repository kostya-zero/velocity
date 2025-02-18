$u = "https://raw.githubusercontent.com/kostya-zero/velocity/main/velocity.ps1"
$p = $PROFILE
$d = Split-Path $p -Parent

# Create parent directory if it does not exist
$null = New-Item $d -Type Directory -Force -EA 0

$s = Join-Path $d (Split-Path $u -Leaf)

# Download the velocity script
$null = Invoke-RestMethod $u -OutFile $s

if (!(Test-Path $p)) {
    $null = New-Item $p -Type File -Force
}

$l = ". `"$s`""
if (!(Select-String -Path $p -Pattern ([regex]::Escape($l)) -Quiet)) {
    $null = Add-Content $p "`n$l"
}

Write-Host "Velocity has been installed. Please restart PowerShell to apply changes."