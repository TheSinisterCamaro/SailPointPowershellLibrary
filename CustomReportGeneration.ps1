# Import the Active Directory module
Import-Module ActiveDirectory

# Define the department to report on
$departmentName = "Finance"

# Get users in the specified department
$users = Get-ADUser -Filter { Department -eq $departmentName } -Properties SamAccountName, DisplayName, EmailAddress, Title

# Initialize an array to store report data
$reportData = @()

foreach ($user in $users) {
    # Get user's group memberships
    $groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName | Select-Object -ExpandProperty Name

    $reportData += [PSCustomObject]@{
        UserName      = $user.SamAccountName
        DisplayName   = $user.DisplayName
        EmailAddress  = $user.EmailAddress
        Title         = $user.Title
        Groups        = $groups -join "; "
    }
}

# Export the report to a CSV file
$reportPath = "C:\Reports\FinanceDepartmentUsers.csv"
$reportData | Export-Csv -Path $reportPath -NoTypeInformation

# Output the result
Write-Host "Custom report generated at $reportPath"
