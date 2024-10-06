# Define SMS gateway API endpoint and credentials
$smsApiUrl = "https://sms-gateway.example.com/api/send"
$smsApiToken = "YourSMSApiToken"

# Define the list of phone numbers to alert
$phoneNumbers = @("1234567890", "0987654321")

# Define the alert message
$message = "Critical alert: Security breach detected. Immediate action required."

foreach ($phoneNumber in $phoneNumbers) {
    # Prepare SMS data
    $smsData = @{
        "to"      = $phoneNumber
        "message" = $message
    }

    # Convert SMS data to JSON
    $smsDataJson = $smsData | ConvertTo-Json

    # Send the SMS
    Invoke-RestMethod -Method POST -Uri $smsApiUrl -Headers @{
        "Authorization" = "Bearer $smsApiToken"
        "Content-Type"  = "application/json"
    } -Body $smsDataJson

    # Output the result
    Write-Host "Sent SMS alert to $phoneNumber"
}

# Output completion message
Write-Host "SMS alert script completed."
