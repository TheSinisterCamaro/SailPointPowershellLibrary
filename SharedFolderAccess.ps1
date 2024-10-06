# Define the path to the shared folder
$sharedFolderPath = "\\ServerName\SharedFolder"

# Define the list of users and their access levels from a CSV file
$csvPath = "C:\SharedFolderAccess.csv"
$accessRequests = Import-Csv -Path $csvPath

foreach ($request in $accessRequests) {
    # Convert the user account to a security identifier (SID)
    $userAccount = New-Object System.Security.Principal.NTAccount($request.Domain, $request.UserName)
    $userSID = $userAccount.Translate([System.Security.Principal.SecurityIdentifier])

    # Get the current ACL
    $acl = Get-Acl -Path $sharedFolderPath

    # Define the file system rights
    $rights = [System.Security.AccessControl.FileSystemRights]::$request.AccessLevel

    # Create a new access rule
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($userSID, $rights, 'Allow')

    # Modify the ACL
    $acl.AddAccessRule($accessRule)
    Set-Acl -Path $sharedFolderPath -AclObject $acl

    # Output the result
    Write-Host "Set $($request.AccessLevel) access for $($request.UserName) on $sharedFolderPath"
}
