# Define the SOAP web service URL
$serviceUrl = "https://your-legacy-system.com/service.asmx?WSDL"

# Create a SOAP client proxy
$soapClient = New-WebServiceProxy -Uri $serviceUrl -Namespace "LegacyService"

# Call a method from the SOAP service
$result = $soapClient.GetUserDetails("username")

# Output the result
Write-Host "User Details:"
Write-Host "Name: $($result.Name)"
Write-Host "Email: $($result.Email)"
