# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/tasks"
$apiToken = "YourSailPointAPIToken"

# Define the task name to execute
$taskName = "Active Directory Aggregation"

# Find the task ID based on the task name
$tasks = Invoke-RestMethod -Method GET -Uri $apiUrl -Headers @{
    "Authorization" = "Bearer $apiToken"
}

$task = $tasks | Where-Object { $_.name -eq $taskName }

if ($task) {
    $taskId = $task.id

    # Execute the task
    $response = Invoke-RestMethod -Method POST -Uri "$apiUrl/$taskId/execute" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    # Output the result
    Write-Host "Task execution initiated for: $taskName"

    # Optionally, monitor the task execution status
    $taskStatusUrl = $response.statusUrl

    do {
        Start-Sleep -Seconds 10
        $statusResponse = Invoke-RestMethod -Method GET -Uri $taskStatusUrl -Headers @{
            "Authorization" = "Bearer $apiToken"
        }
        Write-Host "Task status: $($statusResponse.status)"
    } while ($statusResponse.status -ne "Completed")

    Write-Host "Task execution completed for: $taskName"
} else {
    Write-Host "Task not found: $taskName"
}
