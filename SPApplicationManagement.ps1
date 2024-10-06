# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/applications"
$apiToken = "YourSailPointAPIToken"

# Path to the JSON file containing application configurations
$appConfigPath = "C:\Applications\NewApplication.json"

# Read the application configuration
$appConfigJson = Get-Content -Path $appConfigPath -Raw

# Create the application in SailPoint
$response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type"  = "application/json"
} -Body $appConfigJson

# Output the result
Write-Host "Application onboarded: $($response.name)"
