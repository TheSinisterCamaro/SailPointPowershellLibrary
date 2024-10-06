# Define SMTP server settings
$smtpServer = "smtp.yourdomain.com"
$fromEmail = "no-reply@yourdomain.com"

# Import the list of recipients from a CSV file
$recipients = Import-Csv -Path "C:\EmailRecipients.csv"

# Define the email subject and body
$subject = "Important Company Announcement"
$body = @"
Dear Team,

We are pleased to announce the rollout of our new company policies. Please review the attached documents for detailed information.

Best regards,
Management
"@

foreach ($recipient in $recipients) {
    # Send the email
    Send-MailMessage -From $fromEmail -To $recipient.EmailAddress -Subject $subject -Body $body -SmtpServer $smtpServer

    # Output the result
    Write-Host "Email sent to $($recipient.EmailAddress)"
}

# Output completion message
Write-Host "Bulk email sending complete."
