# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/passwords"
$apiToken = "YourSailPointAPIToken"

# Path to the list of identities for password reset
$identityListPath = "C:\IdentitiesForPasswordReset.txt"

# Get the list of identities
$identities = Get-Content -Path $identityListPath

foreach ($identityName in $identities) {
    # Prepare password reset data
    $resetData = @{
        "identityName" = $identityName
        "password"     = "NewTemporaryPassword123!"
    }

    $resetJson = $resetData | ConvertTo-Json

    # Reset the password
    $response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
        "Authorization" = "Bearer $apiToken"
        "Content-Type"  = "application/json"
    } -Body $resetJson

    # Output the result
    Write-Host "Password reset for identity: $identityName"
}

# Output completion message
Write-Host "Bulk password reset completed."
