# Define the data file to encrypt
$dataFilePath = "C:\SensitiveData.csv"
$encryptedFilePath = "C:\SensitiveData_encrypted.dat"

# Define encryption key (use a secure method to store and retrieve the key)
$encryptionKey = (Get-Content "C:\EncryptionKey.txt")

# Read the data
$data = Get-Content -Path $dataFilePath -Raw

# Convert data to bytes
$dataBytes = [System.Text.Encoding]::UTF8.GetBytes($data)

# Convert key to bytes
$keyBytes = [Convert]::FromBase64String($encryptionKey)

# Encrypt the data
$encryptedData = [System.Security.Cryptography.ProtectedData]::Protect($dataBytes, $keyBytes, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)

# Save the encrypted data
[IO.File]::WriteAllBytes($encryptedFilePath, $encryptedData)

# Output the result
Write-Host "Data encrypted and saved to $encryptedFilePath"
