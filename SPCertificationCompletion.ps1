# Define SailPoint API credentials
$apiUrl = "https://your-sailpoint-instance.com/api/certifications"
$apiToken = "YourSailPointAPIToken"

# Retrieve all active certifications
$certifications = Invoke-RestMethod -Method GET -Uri "$apiUrl?status=Active" -Headers @{
    "Authorization" = "Bearer $apiToken"
}

foreach ($certification in $certifications) {
    $certId = $certification.id

    # Check if all items are reviewed
    $items = Invoke-RestMethod -Method GET -Uri "$apiUrl/$certId/items" -Headers @{
        "Authorization" = "Bearer $apiToken"
    }

    $pendingItems = $items | Where-Object { $_.status -eq "Pending" }

    if ($pendingItems.Count -eq 0) {
        # Complete the certification
        $response = Invoke-RestMethod -Method POST -Uri "$apiUrl/$certId/complete" -Headers @{
            "Authorization" = "Bearer $apiToken"
        }

        # Output the result
        Write-Host "Certification completed: $($certification.name)"
    } else {
        Write-Host "Certification still has pending items: $($certification.name)"
    }
}

# Output completion message
Write-Host "Certification completion process completed."
