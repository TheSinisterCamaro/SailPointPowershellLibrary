# Import the Active Directory module
Import-Module ActiveDirectory

# Get all enabled users
$enabledUsers = Get-ADUser -Filter { Enabled -eq $true }

# Count the number of enabled users
$activeUserCount = $enabledUsers.Count

# Prepare the report data
$reportData = @()
$reportData += New-Object PSObject -Property @{
    TotalUsers      = (Get-ADUser -Filter *).Count
    ActiveUsers     = $activeUserCount
    InactiveUsers   = (Get-ADUser -Filter { Enabled -eq $false }).Count
    ReportDate      = Get-Date
}

# Export the data to a CSV file
$reportData | Export-Csv -Path "C:\LicenseUsageReport.csv" -NoTypeInformation

# Output the result
Write-Host "License usage report generated at C:\LicenseUsageReport.csv"
