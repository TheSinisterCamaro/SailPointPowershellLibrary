# Import necessary modules
Import-Module ActiveDirectory

# Define the time range for log analysis
$startTime = (Get-Date).AddHours(-1) # Last hour
$endTime = Get-Date

# Define a threshold for login failures
$failedLoginThreshold = 5

# Retrieve security logs for failed login attempts (Event ID 4625)
$failedLogins = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4625
    StartTime = $startTime
    EndTime   = $endTime
}

# Group failed logins by account
$failedLoginCounts = $failedLogins | Group-Object -Property @{
    $_.Properties[5].Value # Account name is in property 5
} | Select-Object Name, Count

# Identify accounts exceeding the threshold
$anomalies = $failedLoginCounts | Where-Object { $_.Count -ge $failedLoginThreshold }

if ($anomalies) {
    # Prepare alert message
    $alertMessage = "Anomaly Detection Alert:`n`n"
    foreach ($anomaly in $anomalies) {
        $alertMessage += "Account: $($anomaly.Name), Failed Logins: $($anomaly.Count)`n"
    }

    # Send email alert
    $to = "admin@yourdomain.com"
    $subject = "Anomaly Detection Alert - Failed Logins"
    $smtpServer = "smtp.yourdomain.com"

    Send-MailMessage -To $to -Subject $subject -Body $alertMessage -SmtpServer $smtpServer

    # Output the result
    Write-Host "Anomaly detected. Alert sent to administrator."
} else {
    Write-Host "No anomalies detected."
}
