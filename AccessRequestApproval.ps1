# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing access requests
$csvPath = "C:\AccessRequests.csv"

# Import request data from CSV
$requests = Import-Csv -Path $csvPath

foreach ($request in $requests) {
    # Add user to the requested group
    Add-ADGroupMember -Identity $request.GroupName -Members $request.SamAccountName

    # Output the result
    Write-Host "Approved access: Added $($request.SamAccountName) to $($request.GroupName)"
}
