# Define HR system API endpoint and credentials
$hrApiUrl = "https://hr-system.example.com/api/employees"
$hrApiToken = "YourHRSystemAPIToken"

# Retrieve employee data from HR system
$employees = Invoke-RestMethod -Method GET -Uri $hrApiUrl -Headers @{
    "Authorization" = "Bearer $hrApiToken"
}

foreach ($employee in $employees) {
    # Check if the employee is active
    if ($employee.status -eq "Active") {
        # Create or update user in Active Directory
        # Prepare user properties
        $userProps = @{
            SamAccountName           = $employee.username
            Name                     = "$($employee.firstName) $($employee.lastName)"
            GivenName                = $employee.firstName
            Surname                  = $employee.lastName
            DisplayName              = "$($employee.firstName) $($employee.lastName)"
            UserPrincipalName        = "$($employee.username)@yourdomain.com"
            Path                     = "OU=Employees,DC=yourdomain,DC=com"
            Enabled                  = $true
            EmailAddress             = $employee.email
            Department               = $employee.department
            Title                    = $employee.title
        }

        # Check if the user exists
        $adUser = Get-ADUser -Filter "SamAccountName -eq '$($employee.username)'" -ErrorAction SilentlyContinue

        if ($adUser) {
            # Update existing user
            Set-ADUser -Identity $adUser.SamAccountName @userProps
            Write-Host "Updated user: $($adUser.SamAccountName)"
        } else {
            # Create new user
            New-ADUser @userProps -AccountPassword (ConvertTo-SecureString "DefaultPassword123!" -AsPlainText -Force) -ChangePasswordAtLogon $true
            Write-Host "Created new user: $($employee.username)"
        }
    } elseif ($employee.status -eq "Terminated") {
        # Disable user account
        Disable-ADAccount -Identity $employee.username
        Write-Host "Disabled user: $($employee.username)"
    }
}

# Output completion message
Write-Host "HR system integration script completed."
