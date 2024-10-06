# Import the Active Directory module
Import-Module ActiveDirectory

# Define dynamic access policies
$policies = @{
    "TimeRestrictedAccessGroup" = @{
        StartTime = "08:00"
        EndTime   = "18:00"
    }
}

# Get the current time
$currentTime = (Get-Date).TimeOfDay

foreach ($policy in $policies.GetEnumerator()) {
    $groupName = $policy.Key
    $startTime = [TimeSpan]::Parse($policy.Value.StartTime)
    $endTime   = [TimeSpan]::Parse($policy.Value.EndTime)

    # Determine if current time is outside allowed access time
    if ($currentTime -lt $startTime -or $currentTime -gt $endTime) {
        # Get all members of the group
        $groupMembers = Get-ADGroupMember -Identity $groupName

        foreach ($member in $groupMembers) {
            # Remove the user from the group
            Remove-ADGroupMember -Identity $groupName -Members $member -Confirm:$false

            # Output the result
            Write-Host "Removed user $($member.SamAccountName) from $groupName due to time restrictions."
        }
    } else {
        # Optionally, re-add users to the group during allowed times
        # Implementation depends on your specific requirements
        Write-Host "Current time is within allowed access period for $groupName."
    }
}
