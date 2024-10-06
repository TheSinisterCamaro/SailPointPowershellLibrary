# Define the key vault or storage location
$keyVaultName = "YourKeyVault"

# Authenticate to Azure (if using Azure Key Vault)
Connect-AzAccount

# Get the list of keys to rotate
$keys = Get-AzKeyVaultKey -VaultName $keyVaultName

foreach ($key in $keys) {
    # Create a new version of the key
    $newKey = Add-AzKeyVaultKey -VaultName $keyVaultName -Name $key.Name -Destination $key.Attributes.Origin

    # Update applications or services to use the new key
    # This step depends on how your applications retrieve and use keys
    # For example, update a configuration file or restart services

    # Output the result
    Write-Host "Rotated key: $($key.Name) in key vault: $keyVaultName"
}

# Output completion message
Write-Host "Encryption key rotation completed."
