# Install and import the Microsoft Online module if not already installed
# Install-Module -Name MSOnline
Import-Module MSOnline

# Connect to Microsoft Online
Connect-MsolService

# Import the list of users and their license assignments from a CSV file
$users = Import-Csv -Path "C:\LicenseAssignments.csv"

foreach ($user in $users) {
    # Assign or remove licenses based on the CSV data
    if ($user.Action -eq "Assign") {
        Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName -AddLicenses $user.LicenseSku

        # Output the result
        Write-Host "Assigned license $($user.LicenseSku) to $($user.UserPrincipalName)"
    } elseif ($user.Action -eq "Remove") {
        Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName -RemoveLicenses $user.LicenseSku

        # Output the result
        Write-Host "Removed license $($user.LicenseSku) from $($user.UserPrincipalName)"
    }
}

# Output completion message
Write-Host "License management completed."
