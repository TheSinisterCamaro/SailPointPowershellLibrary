# Define the path to export the audit logs
$auditLogPath = "C:\AuditLogs.csv"

# Define the time range for the audit logs
$startDate = (Get-Date).AddDays(-30)
$endDate = Get-Date

# Get security event logs (example: Event ID 4720 for user account creation)
$events = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    StartTime = $startDate
    EndTime   = $endDate
    Id        = 4720  # Change this ID based on the events you want to capture
}

# Initialize an array to store event data
$eventData = @()

foreach ($event in $events) {
    $eventData += New-Object PSObject -Property @{
        TimeCreated   = $event.TimeCreated
        EventId       = $event.Id
        LevelDisplayName = $event.LevelDisplayName
        Message       = $event.Message
    }
}

# Export the data to a CSV file
$eventData | Export-Csv -Path $auditLogPath -NoTypeInformation

# Output the result
Write-Host "Audit logs exported to $auditLogPath"
