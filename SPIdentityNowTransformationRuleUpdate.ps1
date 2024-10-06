# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/identitynow/api"
$apiToken = "YourSailPointAPIToken"

# Define the source ID for which to update the transformation rule
$sourceId = "1234567890"

# Path to the new transformation rule file
$transformationRulePath = "C:\TransformationRules\NewRule.js"

# Read the new transformation rule
$transformationRuleContent = Get-Content -Path $transformationRulePath -Raw

# Prepare the update data
$updateData = @{
    "transformation" = $transformationRuleContent
}

$updateJson = $updateData | ConvertTo-Json

# Update the transformation rule for the source
$response = Invoke-RestMethod -Method PUT -Uri "$apiUrl/v2/sources/$sourceId/transforms" -Headers @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type"  = "application/json"
} -Body $updateJson

# Output the result
Write-Host "Transformation rule updated for source ID: $sourceId"
