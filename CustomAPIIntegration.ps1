# Define API endpoint and credentials
$apiUrl = "https://custom-api.example.com/endpoint"
$apiKey = "YourCustomApiKey"

# Prepare the data to send
$requestData = @{
    "action" = "getStatus"
    "parameters" = @{
        "systemId" = "SYS12345"
    }
}

# Convert data to JSON
$requestJson = $requestData | ConvertTo-Json

# Send the request to the custom API
$response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiKey"
    "Content-Type"  = "application/json"
} -Body $requestJson

# Process the response
if ($response.status -eq "success") {
    Write-Host "API call successful. Status: $($response.data.status)"
} else {
    Write-Host "API call failed. Error: $($response.error.message)"
}
