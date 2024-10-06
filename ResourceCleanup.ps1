# Import the Active Directory module
Import-Module ActiveDirectory

# Define the threshold for inactive computer accounts (e.g., 90 days)
$thresholdDate = (Get-Date).AddDays(-90)

# Find inactive computer accounts
$inactiveComputers = Get-ADComputer -Filter { LastLogonTimestamp -lt $thresholdDate -and Enabled -eq $true } -Properties LastLogonTimestamp

foreach ($computer in $inactiveComputers) {
    # Disable the computer account
    Disable-ADAccount -Identity $computer.DistinguishedName

    # Optionally, move the computer to an OU for disabled computers
    Move-ADObject -Identity $computer.DistinguishedName -TargetPath "OU=Disabled Computers,DC=yourdomain,DC=com"

    # Output the result
    Write-Host "Disabled and moved inactive computer account: $($computer.Name)"
}

# Output completion message
Write-Host "Resource cleanup completed."
