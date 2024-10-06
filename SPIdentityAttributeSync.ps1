# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/identities"
$apiToken = "YourSailPointAPIToken"

# Path to the CSV file containing updated identity attributes
$csvPath = "C:\IdentityAttributes.csv"

# Import attribute data from CSV
$attributes = Import-Csv -Path $csvPath

foreach ($attribute in $attributes) {
    # Find the identity ID based on the name
    $searchResponse = Invoke-RestMethod -Method GET -Uri "$apiUrl?name=$($attribute.IdentityName)" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    if ($searchResponse.count -gt 0) {
        $identityId = $searchResponse[0].id

        # Prepare attribute update data
        $updateData = @{
            "attributes" = @{
                $attribute.AttributeName = $attribute.AttributeValue
            }
        }

        # Convert update data to JSON
        $updateJson = $updateData | ConvertTo-Json

        # Update the identity's attributes
        $response = Invoke-RestMethod -Method PUT -Uri "$apiUrl/$identityId" -Headers @{
            "Authorization" = "Bearer $apiToken"
            "Content-Type"  = "application/json"
        } -Body $updateJson

        # Output the result
        Write-Host "Updated attribute for identity: $($attribute.IdentityName)"
    } else {
        Write-Host "Identity not found: $($attribute.IdentityName)"
    }
}

# Output completion message
Write-Host "Identity attribute synchronization completed."
