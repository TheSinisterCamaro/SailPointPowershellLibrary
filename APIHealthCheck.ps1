# Define the list of API endpoints to monitor
$apiEndpoints = @(
    "https://api.service1.com/health",
    "https://api.service2.com/health",
    "https://api.service3.com/health"
)

# Initialize an array to store health check results
$healthCheckResults = @()

foreach ($endpoint in $apiEndpoints) {
    $startTime = Get-Date
    try {
        $response = Invoke-WebRequest -Uri $endpoint -UseBasicParsing -TimeoutSec 10
        $endTime = Get-Date
        $responseTime = ($endTime - $startTime).TotalMilliseconds

        if ($response.StatusCode -eq 200) {
            $status = "Healthy"
        } else {
            $status = "Unhealthy"
        }
    } catch {
        $status = "Unreachable"
        $responseTime = "N/A"
    }

    $healthCheckResults += [PSCustomObject]@{
        Endpoint     = $endpoint
        Status       = $status
        ResponseTime = $responseTime
        Timestamp    = Get-Date
    }

    # Output the result
    Write-Host "Checked $endpoint: $status"
}

# Export the health check results to a CSV file
$healthCheckResults | Export-Csv -Path "C:\APIHealthCheckResults.csv" -NoTypeInformation

# Output completion message
Write-Host "API health check completed."
