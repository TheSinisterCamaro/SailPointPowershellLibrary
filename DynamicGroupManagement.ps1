# Import the Active Directory module
Import-Module ActiveDirectory

# Define dynamic group criteria (Group Name to LDAP Filter)
$dynamicGroups = @{
    "ITStaffGroup"        = "(Department=IT)"
    "FinanceStaffGroup"   = "(Department=Finance)"
    "ManagersGroup"       = "(Title=*Manager*)"
}

foreach ($groupName in $dynamicGroups.Keys) {
    # Get current group members
    $currentMembers = Get-ADGroupMember -Identity $groupName -Recursive | Select-Object SamAccountName

    # Get users matching the criteria
    $ldapFilter = $dynamicGroups[$groupName]
    $matchingUsers = Get-ADUser -LDAPFilter $ldapFilter

    # Determine users to add and remove
    $usersToAdd = $matchingUsers | Where-Object { $_.SamAccountName -notin $currentMembers.SamAccountName }
    $usersToRemove = $currentMembers | Where-Object { $_.SamAccountName -notin $matchingUsers.SamAccountName }

    # Add users to the group
    if ($usersToAdd) {
        Add-ADGroupMember -Identity $groupName -Members $usersToAdd.SamAccountName
        Write-Host "Added users to $groupName : $($usersToAdd.SamAccountName -join ', ')"
    }

    # Remove users from the group
    if ($usersToRemove) {
        Remove-ADGroupMember -Identity $groupName -Members $usersToRemove.SamAccountName -Confirm:$false
        Write-Host "Removed users from $groupName : $($usersToRemove.SamAccountName -join ', ')"
    }
}
