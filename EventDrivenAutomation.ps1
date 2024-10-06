# Set up a FileSystemWatcher to monitor a directory for new files (simulating events)
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\EventFolder"
$watcher.Filter = "*.json"
$watcher.EnableRaisingEvents = $true

# Define the action to take when an event occurs
$action = {
    $path = $Event.SourceEventArgs.FullPath
    Write-Host "Event detected: New file $path"

    # Read the event data from the file
    $eventData = Get-Content -Path $path | ConvertFrom-Json

    # Example: If the event is a new user, create the user in Active Directory
    if ($eventData.EventType -eq "UserCreated") {
        $userProps = @{
            SamAccountName      = $eventData.UserName
            Name                = "$($eventData.FirstName) $($eventData.LastName)"
            GivenName           = $eventData.FirstName
            Surname             = $eventData.LastName
            UserPrincipalName   = "$($eventData.UserName)@yourdomain.com"
            Path                = "OU=Employees,DC=yourdomain,DC=com"
            AccountPassword     = (ConvertTo-SecureString "DefaultPassword123!" -AsPlainText -Force)
            Enabled             = $true
        }

        New-ADUser @userProps -ChangePasswordAtLogon $true
        Write-Host "Created new user: $($eventData.UserName)"
    }
}

# Register the event handler
Register-ObjectEvent $watcher 'Created' -Action $action

# Keep the script running
Write-Host "Monitoring events... Press Enter to exit."
Read-Host

# Clean up
Unregister-Event -SourceIdentifier $watcher.GetHashCode()
$watcher.Dispose()
