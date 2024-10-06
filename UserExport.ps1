# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users with specific properties
$users = Get-ADUser -Filter * -Properties SamAccountName, Name, EmailAddress, Department, Title

# Export user data to a CSV file
$users | Select-Object SamAccountName, Name, EmailAddress, Department, Title | Export-Csv -Path "C:\ADUsers.csv" -NoTypeInformation

# Output the result
Write-Host "User data exported to C:\ADUsers.csv"
