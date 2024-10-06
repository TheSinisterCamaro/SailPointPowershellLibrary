# SailPoint API credentials
$sailpointApiUrl = "https://your-sailpoint-instance.com/api"
$sailpointApiToken = "YourSailPointAPIToken"

# Third-party application API credentials
$thirdPartyApiUrl = "https://third-party-app.com/api"
$thirdPartyApiToken = "YourThirdPartyAPIToken"

# Retrieve users from SailPoint
$identities = Invoke-RestMethod -Method GET -Uri "$sailpointApiUrl/identities" -Headers @{
    "Authorization" = "Bearer $sailpointApiToken"
}

foreach ($identity in $identities) {
    # Prepare user data for third-party application
    $userData = @{
        "username"  = $identity.username
        "email"     = $identity.email
        "firstName" = $identity.firstName
        "lastName"  = $identity.lastName
    }

    # Convert user data to JSON
    $userDataJson = $userData | ConvertTo-Json

    # Send user data to the third-party application
    $response = Invoke-RestMethod -Method POST -Uri "$thirdPartyApiUrl/users" -Headers @{
        "Authorization" = "Bearer $thirdPartyApiToken"
        "Content-Type"  = "application/json"
    } -Body $userDataJson

    # Output the result
    Write-Host "Synchronized user: $($identity.username)"
}

# Output completion message
Write-Host "Third-party application integration complete."
