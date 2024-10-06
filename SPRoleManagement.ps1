# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/roles"
$apiToken = "YourSailPointAPIToken"

# Path to the CSV file containing role definitions
$csvPath = "C:\Roles.csv"

# Import role data from CSV
$roles = Import-Csv -Path $csvPath

foreach ($role in $roles) {
    # Prepare role data
    $roleData = @{
        "name"        = $role.RoleName
        "description" = $role.Description
        "entitlements" = @(
            @{
                "name" = $role.EntitlementName
                "type" = "group"
            }
        )
    }

    # Convert role data to JSON
    $roleJson = $roleData | ConvertTo-Json -Depth 10

    # Create or update the role
    $existingRole = Invoke-RestMethod -Method GET -Uri "$apiUrl?name=$($role.RoleName)" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    if ($existingRole.count -gt 0) {
        $roleId = $existingRole[0].id
        # Update the role
        $response = Invoke-RestMethod -Method PUT -Uri "$apiUrl/$roleId" -Headers @{
            "Authorization" = "Bearer $apiToken"
            "Content-Type"  = "application/json"
        } -Body $roleJson
        Write-Host "Updated role: $($role.RoleName)"
    } else {
        # Create the role
        $response = Invoke-RestMethod -Method POST -Uri $apiUrl -Headers @{
            "Authorization" = "Bearer $apiToken"
            "Content-Type"  = "application/json"
        } -Body $roleJson
        Write-Host "Created role: $($role.RoleName)"
    }
}

# Output completion message
Write-Host "Role management completed."
