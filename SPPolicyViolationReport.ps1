# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/policyViolations"
$apiToken = "YourSailPointAPIToken"

# Retrieve policy violations
$violations = Invoke-RestMethod -Method GET -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiToken"
}

# Prepare the report data
$reportData = @()

foreach ($violation in $violations) {
    $reportData += [PSCustomObject]@{
        IdentityName = $violation.identity.name
        PolicyName   = $violation.policy.name
        ViolationDate = $violation.detected
        Status       = $violation.status
    }
}

# Export the report to a CSV file
$reportPath = "C:\SailPointPolicyViolations.csv"
$reportData | Export-Csv -Path $reportPath -NoTypeInformation

# Output the result
Write-Host "Policy violation report generated at $reportPath"
