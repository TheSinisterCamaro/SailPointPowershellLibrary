# Import necessary modules

# Define the path to the licenses data
$licenses = Import-Csv -Path "C:\Licenses\Licenses.csv"

# Define the notification period (e.g., 60 days before expiry)
$notificationPeriod = 60

foreach ($license in $licenses) {
    $expiryDate = [datetime]$license.ExpiryDate
    $daysUntilExpiry = ($expiryDate - (Get-Date)).TotalDays

    if ($daysUntilExpiry -le $notificationPeriod -and $daysUntilExpiry -gt 0) {
        # Send notification to the license manager
        $to = $license.ManagerEmail
        $subject = "License Expiry Notice"
        $body = "Dear $($license.ManagerName),

The license for '$($license.SoftwareName)' is set to expire on $($license.ExpiryDate). Please take the necessary steps to renew it.

Thank you."

        $smtpServer = "smtp.yourdomain.com"
        Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer $smtpServer

        # Output the result
        Write-Host "Sent expiry alert for license: $($license.SoftwareName)"
    }
}
