# Define the backup directory
$backupDir = "C:\SailPointBackups\$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api"
$apiToken = "YourAPIToken"

# Backup configurations (example: identity profiles)
$identityProfiles = Invoke-RestMethod -Method GET -Uri "$apiUrl/identity-profiles" -Headers @{ "Authorization" = "Bearer $apiToken" }

# Save configurations to a file
$identityProfiles | ConvertTo-Json -Depth 10 | Out-File -FilePath "$backupDir\identity_profiles.json"

# Output the result
Write-Host "SailPoint configurations backed up to $backupDir"
