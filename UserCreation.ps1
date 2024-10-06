# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing user information
$csvPath = "C:\NewUsers.csv"

# Import user data from CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Define user properties
    $userProps = @{
        SamAccountName      = $user.SamAccountName
        Name                = "$($user.FirstName) $($user.LastName)"
        GivenName           = $user.FirstName
        Surname             = $user.LastName
        UserPrincipalName   = "$($user.SamAccountName)@yourdomain.com"
        Path                = $user.OU
        AccountPassword     = (ConvertTo-SecureString $user.Password -AsPlainText -Force)
        Enabled             = $true
        ChangePasswordAtLogon = $true
    }

    # Create the user
    New-ADUser @userProps

    # Output the result
    Write-Host "Created user: $($user.SamAccountName)"
}
