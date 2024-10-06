# Define backup source and destination
$backupSource = "C:\CriticalData"
$backupDestination = "\\BackupServer\Backups\CriticalData_$(Get-Date -Format 'yyyyMMdd')"

# Create the destination directory if it doesn't exist
if (!(Test-Path -Path $backupDestination)) {
    New-Item -ItemType Directory -Path $backupDestination
}

# Copy files to the backup destination
Robocopy $backupSource $backupDestination /MIR /Z /NP /R:3 /W:5

# Output the result
Write-Host "Backup of $backupSource completed to $backupDestination."
