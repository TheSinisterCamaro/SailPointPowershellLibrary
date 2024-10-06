# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/reports"
$apiToken = "YourSailPointAPIToken"

# Define the report name to generate
$reportName = "User Access Report"

# Find the report ID based on the report name
$reports = Invoke-RestMethod -Method GET -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiToken"
}

$report = $reports | Where-Object { $_.name -eq $reportName }

if ($report) {
    $reportId = $report.id

    # Generate the report
    $response = Invoke-RestMethod -Method POST -Uri "$apiUrl/$reportId/generate" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    # Output the result
    Write-Host "Report generation initiated for: $reportName"

    # Monitor the report generation status
    $reportStatusUrl = $response.statusUrl

    do {
        Start-Sleep -Seconds 10
        $statusResponse = Invoke-RestMethod -Method GET -Uri $reportStatusUrl -Headers @{
            "Authorization" = "Bearer $apiToken"
        }
        Write-Host "Report status: $($statusResponse.status)"
    } while ($statusResponse.status -ne "Completed")

    # Download the report
    $reportFileUrl = $statusResponse.fileUrl
    $reportContent = Invoke-RestMethod -Method GET -Uri $reportFileUrl -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    # Save the report to a file
    $reportFilePath = "C:\Reports\UserAccessReport.csv"
    $reportContent | Out-File -FilePath $reportFilePath

    Write-Host "Report downloaded to: $reportFilePath"
} else {
    Write-Host "Report not found: $reportName"
}
