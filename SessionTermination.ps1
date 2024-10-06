# Import the Active Directory module
Import-Module ActiveDirectory

# Define the list of users whose sessions need to be terminated
$userList = Get-Content -Path "C:\UsersToTerminateSessions.txt"

foreach ($user in $userList) {
    # Get all sessions for the user on all servers
    $servers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

    foreach ($server in $servers) {
        try {
            $sessions = quser /server:$server | Where-Object { $_ -match $user }

            foreach ($session in $sessions) {
                # Extract session ID
                $sessionId = $session.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)[2]

                # Log off the user session
                logoff $sessionId /server:$server

                # Output the result
                Write-Host "Terminated session ID $sessionId for user $user on server $server"
            }
        } catch {
            # Handle errors (e.g., server not accessible)
            Write-Host "Could not retrieve sessions for $user on server $server"
        }
    }
}
