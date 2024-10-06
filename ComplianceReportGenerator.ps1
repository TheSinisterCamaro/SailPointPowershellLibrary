# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to export the compliance report
$reportPath = "C:\ComplianceReport.csv"

# Get all users with specific properties
$users = Get-ADUser -Filter * -Properties SamAccountName, Department, Title, Manager, Enabled, WhenCreated

# Initialize an array to store user data
$userData = @()

foreach ($user in $users) {
    # Get group memberships
    $groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName | Select-Object -ExpandProperty Name

    $userData += New-Object PSObject -Property @{
        UserName       = $user.SamAccountName
        DisplayName    = $user.Name
        Department     = $user.Department
        Title          = $user.Title
        Manager        = $user.Manager
        Enabled        = $user.Enabled
        WhenCreated    = $user.WhenCreated
        Groups         = $groups -join ';'
    }
}

# Export the data to a CSV file
$userData | Export-Csv -Path $reportPath -NoTypeInformation

# Output the result
Write-Host "Compliance report generated at $reportPath"
