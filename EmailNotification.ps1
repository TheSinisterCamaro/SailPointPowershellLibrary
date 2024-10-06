# Define SMTP server settings
$smtpServer = "smtp.yourdomain.com"
$fromEmail = "no-reply@yourdomain.com"

# Get users whose passwords will expire in the next 7 days
$users = Get-ADUser -Filter * -Properties "msDS-UserPasswordExpiryTimeComputed" | Where-Object {
    $_."msDS-UserPasswordExpiryTimeComputed" -ne $null -and
    ([datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed") -lt (Get-Date).AddDays(7))
}

foreach ($user in $users) {
    $toEmail = $user.EmailAddress
    $subject = "Password Expiration Notice"
    $body = "Dear $($user.Name),

Your password will expire on $([datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")). Please change your password before it expires.

Thank you,
IT Support"

    # Send the email
    Send-MailMessage -From $fromEmail -To $toEmail -Subject $subject -Body $body -SmtpServer $smtpServer

    # Output the result
    Write-Host "Sent password expiration notice to $($user.SamAccountName)"
}

# Output completion message
Write-Host "Email notification script completed."
