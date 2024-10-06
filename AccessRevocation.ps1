# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing revocation requests
$csvPath = "C:\AccessRevocations.csv"

# Import revocation data from CSV
$revocations = Import-Csv -Path $csvPath

foreach ($revocation in $revocations) {
    # Remove user from the specified group
    Remove-ADGroupMember -Identity $revocation.GroupName -Members $revocation.SamAccountName -Confirm:$false

    # Output the result
    Write-Host "Revoked access: Removed $($revocation.SamAccountName) from $($revocation.GroupName)"
}
