# Define the path to the custom connector JAR file
$connectorJarPath = "C:\Connectors\CustomConnector.jar"

# Define the SailPoint IdentityIQ installation directory
$identityIqDir = "C:\SailPoint\IdentityIQ"

# Copy the connector JAR file to the connectors directory
$destinationPath = Join-Path -Path $identityIqDir -ChildPath "WEB-INF\lib"
Copy-Item -Path $connectorJarPath -Destination $destinationPath -Force

# Restart the SailPoint application server to load the new connector
# Example for Tomcat server
$tomcatServiceName = "Tomcat9"

Restart-Service -Name $tomcatServiceName -Force

# Output the result
Write-Host "Custom connector deployed and SailPoint application server restarted."
