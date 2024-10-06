# Define the time range for monitoring
$startDate = (Get-Date).AddDays(-1)  # Last 24 hours
$endDate = Get-Date

# Get logon events (Event ID 4624) and account changes (Event IDs 4720-4739)
$eventIDs = @(4624, 4720, 4722, 4723, 4724, 4725, 4726, 4738)

$events = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    StartTime = $startDate
    EndTime   = $endDate
    Id        = $eventIDs
}

# Initialize an array to store event data
$activityData = @()

foreach ($event in $events) {
    $activityData += New-Object PSObject -Property @{
        TimeCreated      = $event.TimeCreated
        EventId          = $event.Id
        LevelDisplayName = $event.LevelDisplayName
        Message          = $event.Message
    }
}

# Export the data to a CSV file
$reportPath = "C:\UserActivityReport.csv"
$activityData | Export-Csv -Path $reportPath -NoTypeInformation

# Output the result
Write-Host "User activity report generated at $reportPath"
