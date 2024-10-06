# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing temporary access requests
$csvPath = "C:\TemporaryAccessRequests.csv"

# Import request data from CSV
$requests = Import-Csv -Path $csvPath

foreach ($request in $requests) {
    # Calculate expiration date
    $expirationDate = (Get-Date).AddDays($request.AccessDurationInDays)

    # Add user to the specified group
    Add-ADGroupMember -Identity $request.GroupName -Members $request.SamAccountName

    # Set the account expiration date
    Set-ADUser -Identity $request.SamAccountName -AccountExpirationDate $expirationDate

    # Output the result
    Write-Host "Granted temporary access to $($request.SamAccountName) for $($request.AccessDurationInDays) days"
}
