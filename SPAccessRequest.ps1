# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/requests"
$apiToken = "YourSailPointAPIToken"

# Path to the CSV file containing access requests
$csvPath = "C:\AccessRequests.csv"

# Import request data from CSV
$requests = Import-Csv -Path $csvPath

foreach ($request in $requests) {
    # Prepare access request data
    $requestData = @{
        "type"      = "AccessRequest"
        "reason"    = $request.Reason
        "requester" = @{
            "name" = $request.RequesterName
        }
        "accessItems" = @(
            @{
                "identityName" = $request.IdentityName
                "entitlement" = @{
                    "name" = $request.EntitlementName
                }
                "operation" = "Add"
            }
        )
    }

    # Convert request data to JSON
    $requestJson = $requestData | ConvertTo-Json -Depth 10

    # Submit the access request
    $response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
        "Authorization" = "Bearer $apiToken"
        "Content-Type"  = "application/json"
    } -Body $requestJson

    # Output the result
    Write-Host "Submitted access request for $($request.IdentityName)"
}

# Output completion message
Write-Host "Access requests submitted."
