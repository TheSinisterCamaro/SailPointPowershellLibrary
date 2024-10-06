# Define the retention period (e.g., retain logs for the last 365 days)
$retentionPeriod = (Get-Date).AddDays(-365)

# Define the path to the audit logs
$auditLogPath = "C:\AuditLogs"

# Get all log files older than the retention period
$oldLogFiles = Get-ChildItem -Path $auditLogPath -File -Recurse | Where-Object {
    $_.LastWriteTime -lt $retentionPeriod
}

foreach ($file in $oldLogFiles) {
    # Delete the log file
    Remove-Item -Path $file.FullName -Force

    # Output the result
    Write-Host "Deleted old audit log: $($file.FullName)"
}

# Output completion message
Write-Host "Audit trail purge completed."
