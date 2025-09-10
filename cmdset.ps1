# Define registry paths and passkey
$TPath1 = "HKCU:\SOFTWARE\VB and VBA Program Settings\VBAScript\Settings"
$TPath2 = "HKCU:\Software\VBAScript"
$FoundPath = ""
$PassKey = "RizalKey"

# Check if registry paths exist
if (Test-Path $TPath1) {
    $FoundPath = $TPath1
} elseif (Test-Path $TPath2) {
    $FoundPath = $TPath2
} else {
    Write-Error "Registry path not found in either $TPath1 or $TPath2. Ensure the registry key exists."
    exit 1
}

# Prompt for passkey
$inputPassKey = Read-Host "PaskKey na naon?:"

# Verify passkey
if ($inputPassKey -eq $PassKey) {
    try {
        # Get current culture's date format (e.g., dd/MM/yyyy for Indonesia)
        $culture = [System.Globalization.CultureInfo]::CurrentCulture
        $dateFormat = $culture.DateTimeFormat.ShortDatePattern
        $newDate = (Get-Date).AddYears(1).ToString($dateFormat)

        # Set FirstRunDate in registry
        Set-ItemProperty -Path $FoundPath -Name "FirstRunDate" -Value $newDate -ErrorAction Stop
        Write-Host "Verifikasi berhasil, nuhun nya !!"
    } catch {
        Write-Error "Aduh sorry Error: $($_.Exception.Message)"
        Write-Error "Kudu make Admin Previlege ngaeksekusina guys"
        exit 1
    }
} else {
    Write-Error "Punten PassKey na lepat"
    exit 1
}
