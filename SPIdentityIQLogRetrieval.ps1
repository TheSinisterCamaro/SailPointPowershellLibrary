# Define the SailPoint IdentityIQ log directory
$logDir = "C:\SailPoint\IdentityIQ\logs"

# Define the pattern for logs to retrieve (e.g., today's logs)
$logPattern = "sailpoint*.log"

# Get the list of log files
$logFiles = Get-ChildItem -Path $logDir -Filter $logPattern

# Combine logs into a single file for analysis
$combinedLogPath = "C:\Logs\IdentityIQ_Combined.log"
Get-Content -Path $logFiles.FullName | Out-File -FilePath $combinedLogPath

# Analyze the logs for errors or warnings
$logContent = Get-Content -Path $combinedLogPath

$errors = $logContent | Select-String -Pattern "ERROR"
$warnings = $logContent | Select-String -Pattern "WARN"

# Output the results
Write-Host "Number of errors found: $($errors.Count)"
Write-Host "Number of warnings found: $($warnings.Count)"

# Optionally, export the errors and warnings to separate files
$errors | Out-File -FilePath "C:\Logs\IdentityIQ_Errors.log"
$warnings | Out-File -FilePath "C:\Logs\IdentityIQ_Warnings.log"
