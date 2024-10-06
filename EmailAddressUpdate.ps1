# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to the CSV file containing user email updates
$csvPath = "C:\EmailUpdates.csv"

# Import user data from CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Update the email address
    Set-ADUser -Identity $user.SamAccountName -EmailAddress $user.NewEmailAddress

    # Output the result
    Write-Host "Updated email address for user: $($user.SamAccountName) to $($user.NewEmailAddress)"
}
