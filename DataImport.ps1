# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing user data from the HR system
$csvPath = "C:\HRUserData.csv"

# Import user data from CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Check if the user exists
    $adUser = Get-ADUser -Filter "EmployeeID -eq '$($user.EmployeeID)'" -Properties EmployeeID

    if ($adUser) {
        # Update user attributes
        Set-ADUser -Identity $adUser.SamAccountName `
            -Title $user.Title `
            -Department $user.Department `
            -OfficePhone $user.OfficePhone

        # Output the result
        Write-Host "Updated user: $($adUser.SamAccountName)"
    } else {
        # Create a new user account
        $userProps = @{
            SamAccountName      = $user.SamAccountName
            Name                = "$($user.FirstName) $($user.LastName)"
            GivenName           = $user.FirstName
            Surname             = $user.LastName
            UserPrincipalName   = "$($user.SamAccountName)@yourdomain.com"
            Path                = "OU=Employees,DC=yourdomain,DC=com"
            AccountPassword     = (ConvertTo-SecureString "DefaultPassword123!" -AsPlainText -Force)
            Enabled             = $true
            Title               = $user.Title
            Department          = $user.Department
            EmployeeID          = $user.EmployeeID
            OfficePhone         = $user.OfficePhone
        }

        New-ADUser @userProps

        # Output the result
        Write-Host "Created new user: $($user.SamAccountName)"
    }
}

# Output completion message
Write-Host "Data import complete."
