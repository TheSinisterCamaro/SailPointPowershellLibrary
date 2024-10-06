# Import necessary modules

# Define policy violation criteria (e.g., users with admin rights not in Admins group)
$adminsGroup = "Domain Admins"

# Get all users with elevated privileges
$elevatedUsers = Get-ADUser -Filter { AdminCount -eq 1 } -Properties AdminCount

foreach ($user in $elevatedUsers) {
    # Check if user is in the Admins group
    $isInAdminsGroup = Get-ADGroupMember -Identity $adminsGroup -Recursive | Where-Object { $_.SamAccountName -eq $user.SamAccountName }

    if (-not $isInAdminsGroup) {
        # Policy violation detected
        $to = "security@yourdomain.com"
        $subject = "Policy Violation Alert"
        $body = "User $($user.SamAccountName) has elevated privileges but is not a member of $adminsGroup group."

        $smtpServer = "smtp.yourdomain.com"
        Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer $smtpServer

        # Output the result
        Write-Host "Policy violation detected for user: $($user.SamAccountName)"
    }
}
