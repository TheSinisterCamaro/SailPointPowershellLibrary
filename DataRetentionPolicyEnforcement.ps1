# Define the retention period (e.g., data older than 7 years)
$retentionPeriod = (Get-Date).AddYears(-7)

# Define the path to data folders (e.g., archived user data)
$dataPaths = @("C:\ArchivedData\UserData", "D:\OldLogs")

foreach ($path in $dataPaths) {
    # Get files older than the retention period
    $oldFiles = Get-ChildItem -Path $path -Recurse | Where-Object { $_.LastWriteTime -lt $retentionPeriod }

    foreach ($file in $oldFiles) {
        # Remove the file
        Remove-Item -Path $file.FullName -Force

        # Output the result
        Write-Host "Removed file: $($file.FullName)"
    }
}

# Output completion message
Write-Host "Data retention policy enforcement complete."
