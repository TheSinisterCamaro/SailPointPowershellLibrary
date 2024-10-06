# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/identitynow/api"
$apiToken = "YourAPIToken"

# Example: Retrieve a list of identities
$identities = Invoke-RestMethod -Method POST -Uri "$apiUrl/v3/search/identities" -Headers @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type" = "application/json"
} -Body '{
    "indices": ["identities"],
    "query": {
        "query": "*"
    }
}'

# Output the result
foreach ($identity in $identities.hits) {
    Write-Host "Identity: $($identity.attributes.name)"
}
