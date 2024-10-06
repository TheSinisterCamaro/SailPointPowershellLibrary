# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing group membership removals
$csvPath = "C:\GroupRemovals.csv"

# Import data from CSV
$groupRemovals = Import-Csv -Path $csvPath

foreach ($removal in $groupRemovals) {
    # Remove user from the group
    Remove-ADGroupMember -Identity $removal.GroupName -Members $removal.SamAccountName -Confirm:$false

    # Output the result
    Write-Host "Removed $($removal.SamAccountName) from $($removal.GroupName)"
}
