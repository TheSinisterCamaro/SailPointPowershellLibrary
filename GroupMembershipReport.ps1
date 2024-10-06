# Import the Active Directory module
Import-Module ActiveDirectory

# Define the groups you want to report on
$groupNames = @("GroupName1", "GroupName2", "GroupName3")

# Initialize an array to store the group membership data
$groupMembershipData = @()

foreach ($groupName in $groupNames) {
    # Get group members
    $groupMembers = Get-ADGroupMember -Identity $groupName -Recursive

    foreach ($member in $groupMembers) {
        # Get user details
        $user = Get-ADUser -Identity $member.SamAccountName -Properties DisplayName, EmailAddress, Department

        # Add the data to the array
        $groupMembershipData += New-Object PSObject -Property @{
            GroupName       = $groupName
            UserName        = $user.DisplayName
            SamAccountName  = $user.SamAccountName
            EmailAddress    = $user.EmailAddress
            Department      = $user.Department
        }
    }
}

# Export the data to a CSV file
$groupMembershipData | Export-Csv -Path "C:\GroupMembershipReport.csv" -NoTypeInformation

# Output the result
Write-Host "Group membership report generated at C:\GroupMembershipReport.csv"
