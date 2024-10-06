# Define the baseline configuration file
$baselineConfigPath = "C:\Baseline\ConfigBaseline.json"
$baselineConfig = Get-Content -Path $baselineConfigPath | ConvertFrom-Json

# Get current system configuration
$currentConfig = @{
    "Services" = Get-Service | Select-Object Name, Status
    "InstalledSoftware" = Get-WmiObject -Class Win32_Product | Select-Object Name, Version
    # Add more configuration items as needed
}

# Compare current configuration with baseline
$drift = Compare-Object -ReferenceObject $baselineConfig.Services -DifferenceObject $currentConfig.Services -Property Name, Status

# Report drift
if ($drift) {
    $driftReportPath = "C:\Reports\ConfigurationDriftReport_$(Get-Date -Format 'yyyyMMdd').txt"
    $drift | Out-File -FilePath $driftReportPath

    Write-Host "Configuration drift detected. Report saved to $driftReportPath."
} else {
    Write-Host "No configuration drift detected."
}
