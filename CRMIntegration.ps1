# Define CRM API endpoint and credentials
$crmApiUrl = "https://crm.example.com/api/contacts"
$crmApiToken = "YourCRMApiToken"

# Retrieve user data from Active Directory
$users = Get-ADUser -Filter * -Properties EmailAddress, GivenName, Surname

foreach ($user in $users) {
    # Prepare contact data for CRM
    $contactData = @{
        "email"     = $user.EmailAddress
        "firstName" = $user.GivenName
        "lastName"  = $user.Surname
    }

    # Convert contact data to JSON
    $contactDataJson = $contactData | ConvertTo-Json

    # Send contact data to CRM system
    Invoke-RestMethod -Method POST -Uri $crmApiUrl -Headers @{
        "Authorization" = "Bearer $crmApiToken"
        "Content-Type"  = "application/json"
    } -Body $contactDataJson

    # Output the result
    Write-Host "Synchronized contact: $($user.EmailAddress)"
}

# Output completion message
Write-Host "CRM integration script completed."
