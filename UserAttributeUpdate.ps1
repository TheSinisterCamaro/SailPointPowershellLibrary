# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing user attribute updates
$csvPath = "C:\UserAttributeUpdates.csv"

# Import data from CSV
$updates = Import-Csv -Path $csvPath

foreach ($update in $updates) {
    # Update user attributes
    Set-ADUser -Identity $update.SamAccountName -Department $update.Department -Title $update.Title

    # Output the result
    Write-Host "Updated attributes for user: $($update.SamAccountName)"
}
