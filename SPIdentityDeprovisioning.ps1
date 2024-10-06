# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/identities"
$apiToken = "YourSailPointAPIToken"

# Path to the list of identities to deprovision
$identityListPath = "C:\IdentitiesToDeprovision.txt"

# Get the list of identities
$identities = Get-Content -Path $identityListPath

foreach ($identityName in $identities) {
    # Find the identity ID based on the name
    $searchResponse = Invoke-RestMethod -Method GET -Uri "$apiUrl?name=$identityName" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    if ($searchResponse.count -gt 0) {
        $identityId = $searchResponse[0].id

        # Deprovision the identity
        $response = Invoke-RestMethod -Method DELETE -Uri "$apiUrl/$identityId" -Headers @{
            "Authorization" = "Bearer $apiToken"
        }

        # Output the result
        Write-Host "Deprovisioned identity: $identityName"
    } else {
        Write-Host "Identity not found: $identityName"
    }
}

# Output completion message
Write-Host "Identity deprovisioning completed."
