# Import the PKI module
Import-Module PKI

# Define the certificate template and CA
$certTemplate = "WebServer"
$caName = "CA01\YourCA"

# Define the list of servers requiring certificate renewal
$servers = Get-Content -Path "C:\ServersToRenewCerts.txt"

foreach ($server in $servers) {
    # Generate a certificate request
    $certRequest = New-Object -ComObject X509Enrollment.CX509CertificateRequestPkcs10
    $certRequest.InitializeFromTemplateName(0x1, $certTemplate)

    # Enroll for the certificate
    $enrollment = New-Object -ComObject X509Enrollment.CX509Enrollment
    $enrollment.InitializeFromRequest($certRequest)
    $cert = $enrollment.Enroll()

    # Install the certificate on the server
    Invoke-Command -ComputerName $server -ScriptBlock {
        param($certData)
        $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
        $cert.Import([Convert]::FromBase64String($certData))
        $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("My", "LocalMachine")
        $store.Open("ReadWrite")
        $store.Add($cert)
        $store.Close()
    } -ArgumentList $cert

    # Output the result
    Write-Host "Renewed and installed certificate on server: $server"
}
