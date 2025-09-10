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
$inputPassKey = Read-Host "Enter Pass Key"

# Verify passkey
if ($inputPassKey -eq $PassKey) {
    try {
        # Get current culture's date format (e.g., dd/MM/yyyy for Indonesia)
        $culture = [System.Globalization.CultureInfo]::CurrentCulture
        $dateFormat = $culture.DateTimeFormat.ShortDatePattern
        $newDate = (Get-Date).AddYears(1).ToString($dateFormat)

        # Set FirstRunDate in registry
        Set-ItemProperty -Path $FoundPath -Name "FirstRunDate" -Value $newDate -ErrorAction Stop
        Write-Host "FirstRunDate successfully set to $newDate"
    } catch {
        Write-Error "Failed to set registry value. Error: $($_.Exception.Message)"
        Write-Error "Ensure you have permission to modify the registry and run PowerShell as Administrator."
        exit 1
    }
} else {
    Write-Error "Invalid Pass Key"
    exit 1
}
