# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/identities"
$apiToken = "YourSailPointAPIToken"

# Path to the list of identities to unlock
$identityListPath = "C:\IdentitiesToUnlock.txt"

# Get the list of identities
$identities = Get-Content -Path $identityListPath

foreach ($identityName in $identities) {
    # Find the identity ID based on the name
    $searchResponse = Invoke-RestMethod -Method GET -Uri "$apiUrl?name=$identityName" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    if ($searchResponse.count -gt 0) {
        $identityId = $searchResponse[0].id

        # Unlock the account
        $response = Invoke-RestMethod -Method POST -Uri "$apiUrl/$identityId/unlock" -Headers @{
            "Authorization" = "Bearer $apiToken"
        }

        # Output the result
        Write-Host "Unlocked account for identity: $identityName"
    } else {
        Write-Host "Identity not found: $identityName"
    }
}

# Output completion message
Write-Host "Account unlock process completed."
