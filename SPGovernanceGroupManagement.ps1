# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/governanceGroups"
$apiToken = "YourSailPointAPIToken"

# Path to the CSV file containing governance group definitions
$csvPath = "C:\GovernanceGroups.csv"

# Import group data from CSV
$groups = Import-Csv -Path $csvPath

foreach ($group in $groups) {
    # Prepare group data
    $groupData = @{
        "name"        = $group.GroupName
        "description" = $group.Description
        "members"     = $group.Members -split ";"
    }

    # Convert group data to JSON
    $groupJson = $groupData | ConvertTo-Json -Depth 10

    # Create or update the governance group
    $existingGroup = Invoke-RestMethod -Method GET -Uri "$apiUrl?name=$($group.GroupName)" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    if ($existingGroup.count -gt 0) {
        $groupId = $existingGroup[0].id
        # Update the group
        $response = Invoke-RestMethod -Method PUT -Uri "$apiUrl/$groupId" -Headers @{
            "Authorization" = "Bearer $apiToken"
            "Content-Type"  = "application/json"
        } -Body $groupJson
        Write-Host "Updated governance group: $($group.GroupName)"
    } else {
        # Create the group
        $response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
            "Authorization" = "Bearer $apiToken"
            "Content-Type"  = "application/json"
        } -Body $groupJson
        Write-Host "Created governance group: $($group.GroupName)"
    }
}

# Output completion message
Write-Host "Governance group management completed."
