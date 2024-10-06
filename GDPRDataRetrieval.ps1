# Import the Active Directory module
Import-Module ActiveDirectory

# Define the user whose data is requested
$userEmail = "user@example.com"

# Find the user by email
$user = Get-ADUser -Filter "EmailAddress -eq '$userEmail'" -Properties *

if ($user) {
    # Prepare user data
    $userData = $user | Select-Object Name, SamAccountName, EmailAddress, Department, Title, Manager, WhenCreated

    # Export user data to a CSV file
    $dataPath = "C:\GDPRData_$($user.SamAccountName).csv"
    $userData | Export-Csv -Path $dataPath -NoTypeInformation

    # Output the result
    Write-Host "GDPR data for $($user.SamAccountName) exported to $dataPath"
} else {
    Write-Host "User with email $userEmail not found."
}
