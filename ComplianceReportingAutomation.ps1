# Define report generation function
function Generate-ComplianceReport {
    # Import data from various sources
    $userAccessData = Import-Csv -Path "C:\Data\UserAccess.csv"
    $auditLogs = Import-Csv -Path "C:\Data\AuditLogs.csv"

    # Perform compliance analysis
    $nonCompliantUsers = $userAccessData | Where-Object { $_.AccessLevel -gt $_.AllowedAccessLevel }

    # Compile report data
    $reportData = $nonCompliantUsers | Select-Object UserName, AccessLevel, AllowedAccessLevel

    # Export report to CSV
    $reportPath = "C:\Reports\ComplianceReport_$(Get-Date -Format 'yyyyMMdd').csv"
    $reportData | Export-Csv -Path $reportPath -NoTypeInformation

    return $reportPath
}

# Generate the report
$reportFile = Generate-ComplianceReport

# Email the report to stakeholders
$to = "compliance-team@yourdomain.com"
$subject = "Daily Compliance Report"
$body = "Please find the attached compliance report."
$smtpServer = "smtp.yourdomain.com"

Send-MailMessage -To $to -Subject $subject -Body $body -Attachments $reportFile -SmtpServer $smtpServer

# Output the result
Write-Host "Compliance report generated and emailed to $to."
