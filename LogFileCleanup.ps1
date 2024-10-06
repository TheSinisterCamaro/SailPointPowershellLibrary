# Define the log directories and retention period
$logDirectories = @("C:\Logs", "D:\ApplicationLogs")
$retentionPeriod = (Get-Date).AddDays(-30)  # Retain logs for 30 days

foreach ($directory in $logDirectories) {
    # Get log files older than the retention period
    $oldLogs = Get-ChildItem -Path $directory -File -Recurse | Where-Object {
        $_.LastWriteTime -lt $retentionPeriod
    }

    foreach ($log in $oldLogs) {
        # Delete the log file
        Remove-Item -Path $log.FullName -Force

        # Output the result
        Write-Host "Deleted old log file: $($log.FullName)"
    }
}

# Output completion message
Write-Host "Log file cleanup completed."
