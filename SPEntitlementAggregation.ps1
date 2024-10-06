# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/aggregation"
$apiToken = "YourSailPointAPIToken"

# Define the application name for which to aggregate entitlements
$applicationName = "Active Directory"

# Start the aggregation
$aggregationData = @{
    "application" = $applicationName
}

$aggregationJson = $aggregationData | ConvertTo-Json

$response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type"  = "application/json"
} -Body $aggregationJson

# Output the result
Write-Host "Entitlement aggregation initiated for application: $applicationName"

# Optionally, monitor the aggregation status
$aggregationStatusUrl = $response.statusUrl

do {
    Start-Sleep -Seconds 10
    $statusResponse = Invoke-RestMethod -Method GET -Uri $aggregationStatusUrl -Headers @{
        "Authorization" = "Bearer $apiToken"
    }
    Write-Host "Aggregation status: $($statusResponse.status)"
} while ($statusResponse.status -ne "Completed")

Write-Host "Entitlement aggregation completed for application: $applicationName"
