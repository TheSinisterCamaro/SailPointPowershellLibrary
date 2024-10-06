# Import the Active Directory module
Import-Module ActiveDirectory

# Define SoD conflict rules
$conflictRules = @(
    @{ Role1 = "PayrollProcessingGroup"; Role2 = "PayrollApprovalGroup" },
    @{ Role1 = "UserProvisioningGroup"; Role2 = "AccessReviewGroup" }
)

# Get all users
$users = Get-ADUser -Filter * -Properties MemberOf

# Initialize an array to store SoD violations
$sodViolations = @()

foreach ($user in $users) {
    $userGroups = $user.MemberOf | ForEach-Object { (Get-ADGroup $_).Name }

    foreach ($rule in $conflictRules) {
        if ($userGroups -contains $rule.Role1 -and $userGroups -contains $rule.Role2) {
            # SoD violation detected
            $sodViolations += [PSCustomObject]@{
                UserName        = $user.SamAccountName
                ConflictingRoles = "$($rule.Role1) and $($rule.Role2)"
            }

            # Output the violation
            Write-Host "SoD violation for user $($user.SamAccountName): $($rule.Role1) and $($rule.Role2)"
        }
    }
}

# Export SoD violations to a CSV file
$sodViolations | Export-Csv -Path "C:\Reports\SoDViolations.csv" -NoTypeInformation

# Output completion message
Write-Host "Segregation of duties check completed."
