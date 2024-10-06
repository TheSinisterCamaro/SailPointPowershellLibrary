# Import the Active Directory module
Import-Module ActiveDirectory

# Define the list of privileged accounts and their statuses from a CSV file
$csvPath = "C:\PrivilegedAccessChanges.csv"
$privilegedAccounts = Import-Csv -Path $csvPath

foreach ($account in $privilegedAccounts) {
    if ($account.Action -eq "Enable") {
        # Enable the privileged account
        Enable-ADAccount -Identity $account.SamAccountName

        # Output the result
        Write-Host "Enabled privileged account: $($account.SamAccountName)"
    } elseif ($account.Action -eq "Disable") {
        # Disable the privileged account
        Disable-ADAccount -Identity $account.SamAccountName

        # Output the result
        Write-Host "Disabled privileged account: $($account.SamAccountName)"
    }
}
