# Define the encrypted data file
$encryptedFilePath = "C:\SensitiveData_encrypted.dat"

# Define the decryption key (should match the encryption key)
$decryptionKey = (Get-Content "C:\EncryptionKey.txt")

# Read the encrypted data
$encryptedData = [IO.File]::ReadAllBytes($encryptedFilePath)

# Convert key to bytes
$keyBytes = [Convert]::FromBase64String($decryptionKey)

# Decrypt the data
$decryptedDataBytes = [System.Security.Cryptography.ProtectedData]::Unprotect($encryptedData, $keyBytes, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)

# Convert bytes back to string
$decryptedData = [System.Text.Encoding]::UTF8.GetString($decryptedDataBytes)

# Output the result or save to file
Write-Host "Data decrypted successfully."
# Optional: Save to file
# $decryptedData | Out-File -FilePath "C:\SensitiveData_decrypted.csv"
