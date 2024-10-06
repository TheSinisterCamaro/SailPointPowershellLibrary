# Note: SailPoint supports webhooks or event triggers that can call external scripts or services.
# This script assumes it's called when a new identity is created.

param(
    [Parameter(Mandatory = $true)]
    [string]$IdentityName
)

# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/identities"
$apiToken = "YourSailPointAPIToken"

# Retrieve the new identity details
$identity = Invoke-RestMethod -Method GET -Uri "$apiUrl?name=$IdentityName" -Headers @{
    "Authorization" = "Bearer $apiToken"
}

if ($identity.count -gt 0) {
    $identityDetails = $identity[0]

    # Send a welcome email to the new user
    $to = $identityDetails.attributes.email
    $subject = "Welcome to the Company"
    $body = "Dear $($identityDetails.attributes.firstName),

Welcome to the company! Your account has been created.

Best regards,
IT Team"

    $smtpServer = "smtp.yourdomain.com"
    Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer $smtpServer

    # Output the result
    Write-Host "Welcome email sent to: $($identityDetails.attributes.email)"
} else {
    Write-Host "Identity not found: $IdentityName"
}
