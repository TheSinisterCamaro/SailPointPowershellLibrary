# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing group membership additions
$csvPath = "C:\GroupAdditions.csv"

# Import data from CSV
$groupAdditions = Import-Csv -Path $csvPath

foreach ($addition in $groupAdditions) {
    # Add user to the group
    Add-ADGroupMember -Identity $addition.GroupName -Members $addition.SamAccountName

    # Output the result
    Write-Host "Added $($addition.SamAccountName) to $($addition.GroupName)"
}
