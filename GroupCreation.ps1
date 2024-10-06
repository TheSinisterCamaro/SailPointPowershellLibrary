# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to the CSV file containing new groups
$csvPath = "C:\GroupsToCreate.csv"

# Import group data from CSV
$groups = Import-Csv -Path $csvPath

foreach ($group in $groups) {
    # Create group properties
    $groupProps = @{
        Name           = $group.GroupName
        GroupScope     = $group.GroupScope  # Global, DomainLocal, Universal
        Path           = $group.OU
        Description    = $group.Description
        GroupCategory  = "Security"         # Or "Distribution"
    }

    # Create the group
    New-ADGroup @groupProps

    # Output the result
    Write-Host "Created group: $($group.GroupName)"
}
