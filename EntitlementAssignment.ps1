# Import the Active Directory module
Import-Module ActiveDirectory

# Define entitlement rules (Role to Entitlements)
$entitlementRules = @{
    "Finance"    = @("FinanceAppAccess", "FinanceFolderAccess")
    "IT"         = @("ITAppAccess", "ITFolderAccess")
    "HR"         = @("HRAppAccess", "HRFolderAccess")
}

# Get all users
$users = Get-ADUser -Filter * -Properties Department, SamAccountName

foreach ($user in $users) {
    $department = $user.Department

    if ($entitlementRules.ContainsKey($department)) {
        $entitlements = $entitlementRules[$department]

        foreach ($entitlement in $entitlements) {
            # Assign entitlement (e.g., add to group or assign permission)
            Add-ADGroupMember -Identity $entitlement -Members $user.SamAccountName

            # Output the result
            Write-Host "Assigned entitlement $entitlement to $($user.SamAccountName)"
        }
    }
}
