# Define the list of servers to check
$servers = @("Server1", "Server2", "Server3")

# Initialize an array to store health check results
$healthCheckResults = @()

foreach ($server in $servers) {
    # Check system uptime
    $uptime = (Get-CimInstance -ComputerName $server -ClassName Win32_OperatingSystem).LastBootUpTime
    $uptimeDays = (Get-Date) - $uptime

    # Check CPU usage
    $cpuLoad = Get-WmiObject -ComputerName $server -Class Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average

    # Check memory usage
    $os = Get-CimInstance -ComputerName $server -ClassName Win32_OperatingSystem
    $totalMemory = $os.TotalVisibleMemorySize
    $freeMemory = $os.FreePhysicalMemory
    $memoryUsage = [math]::Round((($totalMemory - $freeMemory) / $totalMemory) * 100, 2)

    # Compile health data
    $healthCheckResults += [PSCustomObject]@{
        Server        = $server
        UptimeDays    = [math]::Round($uptimeDays.TotalDays, 2)
        CpuLoad       = $cpuLoad
        MemoryUsage   = "$memoryUsage%"
        Timestamp     = Get-Date
    }

    # Output the result
    Write-Host "Health check for $server completed."
}

# Export health check results to a CSV file
$healthCheckResults | Export-Csv -Path "C:\Reports\SystemHealthCheck.csv" -NoTypeInformation

# Output completion message
Write-Host "System health check completed."
