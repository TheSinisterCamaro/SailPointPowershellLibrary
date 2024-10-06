# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing user updates
$csvPath = "C:\UserUpdates.csv"

# Import data from CSV
$updates = Import-Csv -Path $csvPath

foreach ($update in $updates) {
    # Update user attributes
    Set-ADUser -Identity $update.SamAccountName -EmailAddress $update.EmailAddress -Department $update.Department -Title $update.Title

    # Output the result
    Write-Host "Updated user: $($update.SamAccountName)"
}
