# Define the list of services to monitor
$servicesToMonitor = @("Spooler", "W3SVC", "MSSQLSERVER")

foreach ($serviceName in $servicesToMonitor) {
    # Get the service status
    $service = Get-Service -Name $serviceName

    if ($service.Status -eq "Stopped") {
        # Attempt to restart the service
        Start-Service -Name $serviceName

        # Output the result
        Write-Host "Restarted service: $serviceName"
    } else {
        Write-Host "Service $serviceName is running."
    }
}

# Output completion message
Write-Host "Service restart script completed."
