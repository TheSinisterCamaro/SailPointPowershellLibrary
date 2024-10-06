# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to export the audit report
$reportPath = "C:\PermissionAuditReport.csv"

# Get all users
$users = Get-ADUser -Filter * -Properties SamAccountName

# Initialize an array to store permission data
$permissionData = @()

foreach ($user in $users) {
    # Get group memberships
    $groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName | Select-Object -ExpandProperty Name

    # Get effective permissions (example: file system permissions on a shared folder)
    # Note: Replace 'SharedFolderPath' with the actual path you want to audit
    $acl = Get-Acl -Path "\\ServerName\SharedFolderPath"
    $accessRules = $acl.Access | Where-Object { $_.IdentityReference -eq $user.SamAccountName }

    foreach ($rule in $accessRules) {
        $permissionData += New-Object PSObject -Property @{
            UserName        = $user.SamAccountName
            Groups          = $groups -join ';'
            FileSystemRights = $rule.FileSystemRights
            AccessControlType = $rule.AccessControlType
            InheritanceFlags = $rule.InheritanceFlags
            PropagationFlags = $rule.PropagationFlags
        }
    }
}

# Export the data to a CSV file
$permissionData | Export-Csv -Path $reportPath -NoTypeInformation

# Output the result
Write-Host "Permission audit report generated at $reportPath"
