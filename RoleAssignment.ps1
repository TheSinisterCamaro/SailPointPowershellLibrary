# Import the Active Directory module
Import-Module ActiveDirectory

# Define role mappings (Department to Role Group)
$roleMappings = @{
    "Finance"    = "FinanceRoleGroup"
    "IT"         = "ITRoleGroup"
    "HR"         = "HRRoleGroup"
    "Marketing"  = "MarketingRoleGroup"
}

# Get all users
$users = Get-ADUser -Filter * -Properties Department, SamAccountName

foreach ($user in $users) {
    $department = $user.Department

    if ($roleMappings.ContainsKey($department)) {
        $roleGroup = $roleMappings[$department]

        # Add user to role group
        Add-ADGroupMember -Identity $roleGroup -Members $user.SamAccountName

        # Output the result
        Write-Host "Assigned $($user.SamAccountName) to $roleGroup"
    }
}
