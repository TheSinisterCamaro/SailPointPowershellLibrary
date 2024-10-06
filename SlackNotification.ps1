# Define Slack webhook URL
$slackWebhookUrl = "https://hooks.slack.com/services/Your/Slack/Webhook"

# Define the message payload
$payload = @{
    "text" = "Deployment completed successfully on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')."
}

# Convert payload to JSON
$payloadJson = $payload | ConvertTo-Json

# Send the notification to Slack
Invoke-RestMethod -Method POST -Uri $slackWebhookUrl -ContentType 'application/json' -Body $payloadJson

# Output the result
Write-Host "Slack notification sent."

# Output completion message
Write-Host "Slack notification script completed."
