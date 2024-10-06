# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/identities/refresh"
$apiToken = "YourSailPointAPIToken"

# Trigger identity refresh
$response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiToken"
}

# Output the result
Write-Host "Identity refresh initiated."

# Optionally, monitor the refresh status
$refreshStatusUrl = $response.statusUrl

do {
    Start-Sleep -Seconds 10
    $statusResponse = Invoke-RestMethod -Method GET -Uri $refreshStatusUrl -Headers @{
        "Authorization" = "Bearer $apiToken"
    }
    Write-Host "Refresh status: $($statusResponse.status)"
} while ($statusResponse.status -ne "Completed")

Write-Host "Identity refresh completed."
