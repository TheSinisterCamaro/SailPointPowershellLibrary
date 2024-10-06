# Import necessary modules

# Define the path to the certifications data (could be a CSV or database)
$certifications = Import-Csv -Path "C:\Certifications\Certifications.csv"

# Define the notification period (e.g., 30 days before expiry)
$notificationPeriod = 30

foreach ($cert in $certifications) {
    $expiryDate = [datetime]$cert.ExpiryDate
    $daysUntilExpiry = ($expiryDate - (Get-Date)).TotalDays

    if ($daysUntilExpiry -le $notificationPeriod -and $daysUntilExpiry -gt 0) {
        # Send notification to the responsible person
        $to = $cert.ResponsiblePersonEmail
        $subject = "Certification Expiry Notice"
        $body = "Dear $($cert.ResponsiblePersonName),

The certification '$($cert.CertificationName)' is set to expire on $($cert.ExpiryDate). Please take the necessary steps to renew it.

Thank you."

        $smtpServer = "smtp.yourdomain.com"
        Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer $smtpServer

        # Output the result
        Write-Host "Sent expiry alert for certification: $($cert.CertificationName)"
    }
}
