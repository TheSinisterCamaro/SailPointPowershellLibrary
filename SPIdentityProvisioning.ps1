# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/identities"
$apiToken = "YourSailPointAPIToken"

# Path to the CSV file containing new user information
$csvPath = "C:\NewIdentities.csv"

# Import user data from CSV
$identities = Import-Csv -Path $csvPath

foreach ($identity in $identities) {
    # Prepare identity data
    $identityData = @{
        "name"       = $identity.UserName
        "attributes" = @{
            "firstName" = $identity.FirstName
            "lastName"  = $identity.LastName
            "email"     = $identity.Email
            "department" = $identity.Department
            "title"     = $identity.Title
        }
        "entitlements" = @(
            @{
                "name" = $identity.EntitlementName
                "type" = "group"
            }
        )
    }

    # Convert identity data to JSON
    $identityJson = $identityData | ConvertTo-Json -Depth 10

    # Create the identity in SailPoint
    $response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
        "Authorization" = "Bearer $apiToken"
        "Content-Type"  = "application/json"
    } -Body $identityJson

    # Output the result
    Write-Host "Provisioned new identity: $($identity.UserName)"
}

# Output completion message
Write-Host "Identity provisioning completed."
