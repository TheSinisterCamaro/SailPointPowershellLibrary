# Import the Active Directory module
Import-Module ActiveDirectory

# Define the criteria for obsolete groups (e.g., no members and not modified in over a year)
$thresholdDate = (Get-Date).AddYears(-1)

# Find obsolete groups
$obsoleteGroups = Get-ADGroup -Filter { WhenChanged -lt $thresholdDate } -Properties WhenChanged, Members | Where-Object { -not $_.Members }

foreach ($group in $obsoleteGroups) {
    # Remove the group
    Remove-ADGroup -Identity $group.DistinguishedName -Confirm:$false

    # Output the result
    Write-Host "Removed obsolete group: $($group.Name)"
}

# Output completion message
Write-Host "Obsolete group cleanup complete."
