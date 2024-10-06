# Import the Active Directory module
Import-Module ActiveDirectory

# Get users created in the last day
$startDate = (Get-Date).AddDays(-1)
$newUsers = Get-ADUser -Filter { WhenCreated -ge $startDate } -Properties WhenCreated, Manager

foreach ($user in $newUsers) {
    # Get manager's email
    $manager = Get-ADUser -Identity $user.Manager -Properties EmailAddress

    # Send notification to the manager
    $to = $manager.EmailAddress
    $subject = "New Team Member Onboarded"
    $body = "Dear $($manager.Name),

A new team member, $($user.Name), has joined your team. Please ensure they have the necessary resources and support.

Thank you."

    $smtpServer = "smtp.yourdomain.com"
    Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer $smtpServer

    # Output the result
    Write-Host "Sent onboarding notification for user: $($user.SamAccountName)"
}
