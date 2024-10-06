# Import the required modules
Import-Module ActiveDirectory

# Path to the CSV file containing pending certifications
$csvPath = "C:\PendingCertifications.csv"

# Import certification data from CSV
$certifications = Import-Csv -Path $csvPath

foreach ($cert in $certifications) {
    # Send reminder email to the reviewer
    $to = $cert.ReviewerEmail
    $subject = "Pending Access Certification Reminder"
    $body = "Dear $($cert.ReviewerName),`n`nYou have pending access certifications that require your attention.`nPlease review the access for $($cert.UserName).`n`nThank you."

    Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer "smtp.yourdomain.com"

    # Output the result
    Write-Host "Sent reminder to reviewer: $($cert.ReviewerName)"
}

# Output completion message
Write-Host "Access certification reminders sent."
