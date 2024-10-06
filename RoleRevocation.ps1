# Import the Active Directory module
Import-Module ActiveDirectory

# Define role group mappings (Role Group to Criteria)
$roleRevocationCriteria = @{
    "FinanceRoleGroup"    = "Department -ne 'Finance'"
    "ITRoleGroup"         = "Department -ne 'IT'"
    "HRRoleGroup"         = "Department -ne 'HR'"
    "MarketingRoleGroup"  = "Department -ne 'Marketing'"
}

foreach ($roleGroup in $roleRevocationCriteria.Keys) {
    # Get members of the role group
    $groupMembers = Get-ADGroupMember -Identity $roleGroup -Recursive | Where-Object { $_.ObjectClass -eq 'user' }

    foreach ($member in $groupMembers) {
        # Get user details
        $user = Get-ADUser -Identity $member.SamAccountName -Properties Department

        # Evaluate revocation criteria
        $criteria = $roleRevocationCriteria[$roleGroup]
        if (Invoke-Expression -Command ($criteria -replace 'Department', "`"$($user.Department)`"")) {
            # Remove user from role group
            Remove-ADGroupMember -Identity $roleGroup -Members $user.SamAccountName -Confirm:$false

            # Output the result
            Write-Host "Revoked $roleGroup from $($user.SamAccountName)"
        }
    }
}
