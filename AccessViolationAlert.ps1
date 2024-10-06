# Import the Active Directory module
Import-Module ActiveDirectory

# Define unauthorized group memberships (e.g., users who should not be in certain groups)
$unauthorizedGroups = @{
    "SensitiveGroup1" = @("UserA", "UserB")
    "SensitiveGroup2" = @("UserC", "UserD")
}

# Initialize an array to store violations
$violations = @()

foreach ($groupName in $unauthorizedGroups.Keys) {
    $unauthorizedUsers = $unauthorizedGroups[$groupName]

    # Get current group members
    $groupMembers = Get-ADGroupMember -Identity $groupName -Recursive | Select-Object -ExpandProperty SamAccountName

    # Check for unauthorized users
    foreach ($user in $unauthorizedUsers) {
        if ($groupMembers -contains $user) {
            $violations += New-Object PSObject -Property @{
                GroupName      = $groupName
                UserName       = $user
            }

            # Optionally, remove the unauthorized user from the group
            Remove-ADGroupMember -Identity $groupName -Members $user -Confirm:$false

            # Output the result
            Write-Host "Removed unauthorized user $user from $groupName"
        }
    }
}

# If any violations were found, send an alert email
if ($violations.Count -gt 0) {
    $to = "admin@yourdomain.com"
    $subject = "Access Violation Alert"
    $body = "The following access violations were detected:`n`n"

    foreach ($violation in $violations) {
        $body += "User: $($violation.UserName), Group: $($violation.GroupName)`n"
    }

    Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer "smtp.yourdomain.com"

    Write-Host "Access violation alert sent to $to"
}
