# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/certifications"
$apiToken = "YourSailPointAPIToken"

# Define the certification campaign parameters
$campaignData = @{
    "name"           = "Quarterly Access Review"
    "description"    = "Quarterly review of user access and entitlements."
    "type"           = "EntitlementOwner"
    "startDate"      = (Get-Date).ToString("yyyy-MM-dd")
    "endDate"        = (Get-Date).AddDays(30).ToString("yyyy-MM-dd")
    "certifiers"     = @("manager")
    "reminders"      = @{
        "frequency" = "Weekly"
        "count"     = 3
    }
}

# Convert campaign data to JSON
$campaignJson = $campaignData | ConvertTo-Json -Depth 10

# Create the certification campaign
$response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type"  = "application/json"
} -Body $campaignJson

# Output the result
Write-Host "Certification campaign created: $($campaignData.name)"
