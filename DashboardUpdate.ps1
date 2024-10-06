# Import necessary modules
Import-Module ActiveDirectory

# Define the path to the dashboard data file
$dashboardDataPath = "C:\DashboardData\DashboardData.json"

# Collect metrics (e.g., number of active users, locked accounts)
$activeUsersCount = (Get-ADUser -Filter { Enabled -eq $true }).Count
$lockedAccountsCount = (Get-ADUser -Filter { LockedOut -eq $true }).Count
$pendingApprovalsCount = Get-PendingApprovalsCount # Assume a function that retrieves pending approvals

# Prepare dashboard data
$dashboardData = @{
    Timestamp             = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    ActiveUsers           = $activeUsersCount
    LockedAccounts        = $lockedAccountsCount
    PendingAccessRequests = $pendingApprovalsCount
}

# Convert data to JSON
$dashboardDataJson = $dashboardData | ConvertTo-Json

# Save the data to a file
$dashboardDataJson | Out-File -FilePath $dashboardDataPath

# Optionally, send data to a web dashboard via API
$dashboardApiUrl = "https://your-dashboard.example.com/api/update"
Invoke-RestMethod -Method POST -Uri $dashboardApiUrl -Headers @{
    "Content-Type" = "application/json"
} -Body $dashboardDataJson

# Output the result
Write-Host "Dashboard updated with latest metrics."
