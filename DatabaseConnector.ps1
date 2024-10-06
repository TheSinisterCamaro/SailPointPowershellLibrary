# Define database connection parameters
$serverName = "YourDatabaseServer"
$databaseName = "YourDatabase"
$connectionString = "Server=$serverName;Database=$databaseName;Integrated Security=True;"

# Query to retrieve user data
$query = "SELECT UserID, FirstName, LastName, Email FROM Users"

# Execute the query and store results
$users = Invoke-Sqlcmd -ConnectionString $connectionString -Query $query

foreach ($user in $users) {
    # Prepare user data for SailPoint
    $userData = @{
        "name"       = $user.UserID
        "email"      = $user.Email
        "firstname"  = $user.FirstName
        "lastname"   = $user.LastName
    }

    # Convert user data to JSON
    $userDataJson = $userData | ConvertTo-Json

    # Send user data to SailPoint
    Invoke-RestMethod -Method POST -Uri "$sailpointApiUrl/identities" -Headers @{
        "Authorization" = "Bearer $sailpointApiToken"
        "Content-Type"  = "application/json"
    } -Body $userDataJson

    # Output the result
    Write-Host "Synchronized user: $($user.UserID)"
}

# Output completion message
Write-Host "Database connector script completed."
