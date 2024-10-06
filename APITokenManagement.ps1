# Define SailPoint API endpoint for token management
$apiUrl = "https://your-sailpoint-instance.com/api/tokens"
$adminApiToken = "YourAdminAPIToken"

# Create a new API token
$newTokenResponse = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $adminApiToken"
    "Content-Type"  = "application/json"
} -Body '{
    "name": "ScriptAutomationToken",
    "scopes": ["identity:read", "identity:write"]
}'

# Store the new token securely
$newToken = $newTokenResponse.token

# Save the token to a secure location (e.g., Windows Credential Manager)
$credential = New-Object -TypeName PSCredential -ArgumentList "SailPointAPIToken", (ConvertTo-SecureString $newToken -AsPlainText -Force)
$credential | Export-Clixml -Path "C:\SecureStore\SailPointAPIToken.xml"

# Output the result
Write-Host "New API token created and stored securely."
