# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/workflows"
$apiToken = "YourSailPointAPIToken"

# Define the workflow to trigger
$workflowName = "ProvisionNewUser"

# Define the input parameters for the workflow
$workflowInput = @{
    "userName"  = "newuser"
    "firstName" = "New"
    "lastName"  = "User"
    "email"     = "newuser@yourdomain.com"
}

# Convert input parameters to JSON
$workflowInputJson = $workflowInput | ConvertTo-Json

# Trigger the workflow
$response = Invoke-RestMethod -Method POST -Uri "$apiUrl/$workflowName/execute" -Headers @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type"  = "application/json"
} -Body $workflowInputJson

# Output the result
Write-Host "Workflow '$workflowName' triggered for user: $($workflowInput.userName)"
