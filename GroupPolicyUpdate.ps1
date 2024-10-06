# Import the Group Policy module
Import-Module GroupPolicy

# Define the list of Group Policy Objects (GPOs) to update
$gpoNames = @("GPO1", "GPO2", "GPO3")

foreach ($gpoName in $gpoNames) {
    # Retrieve the GPO
    $gpo = Get-GPO -Name $gpoName -ErrorAction SilentlyContinue

    if ($gpo) {
        # Modify the GPO settings using Set-GPRegistryValue or other cmdlets
        Set-GPRegistryValue -Name $gpoName -Key "HKLM\Software\MyCompany" -ValueName "Setting1" -Type String -Value "NewValue"

        # Output the result
        Write-Host "Updated $gpoName with new settings."
    } else {
        Write-Host "GPO not found: $gpoName"
    }
}
