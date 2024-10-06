# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to the CSV file containing custom attribute updates
$csvPath = "C:\CustomAttributeUpdates.csv"

# Import user data from CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Update custom attributes
    Set-ADUser -Identity $user.SamAccountName -Add @{
        extensionAttribute1 = $user.CustomAttribute1
        extensionAttribute2 = $user.CustomAttribute2
    }

    # Output the result
    Write-Host "Updated custom attributes for user: $($user.SamAccountName)"
}
