# Import required modules
Import-Module ActiveDirectory

# Define the path to the access requests CSV file
$csvPath = "C:\AccessRequests.csv"

# Import access requests from CSV
$accessRequests = Import-Csv -Path $csvPath

foreach ($request in $accessRequests) {
    if ($request.Action -eq "Grant") {
        # Add user to the requested group
        Add-ADGroupMember -Identity $request.GroupName -Members $request.SamAccountName

        # Output the result
        Write-Host "Granted access: Added $($request.SamAccountName) to $($request.GroupName)"
    } elseif ($request.Action -eq "Revoke") {
        # Remove user from the requested group
        Remove-ADGroupMember -Identity $request.GroupName -Members $request.SamAccountName -Confirm:$false

        # Output the result
        Write-Host "Revoked access: Removed $($request.SamAccountName) from $($request.GroupName)"
    }
}
