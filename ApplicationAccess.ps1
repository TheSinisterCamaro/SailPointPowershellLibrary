# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing application access changes
$csvPath = "C:\ApplicationAccessChanges.csv"

# Import access change data from CSV
$accessChanges = Import-Csv -Path $csvPath

foreach ($change in $accessChanges) {
    if ($change.Action -eq "Grant") {
        # Add user to the application access group
        Add-ADGroupMember -Identity $change.ApplicationGroup -Members $change.SamAccountName

        # Output the result
        Write-Host "Granted access to $($change.ApplicationName) for user $($change.SamAccountName)"
    } elseif ($change.Action -eq "Revoke") {
        # Remove user from the application access group
        Remove-ADGroupMember -Identity $change.ApplicationGroup -Members $change.SamAccountName -Confirm:$false

        # Output the result
        Write-Host "Revoked access to $($change.ApplicationName) for user $($change.SamAccountName)"
    }
}
