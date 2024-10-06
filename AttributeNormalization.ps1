# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users with phone numbers
$users = Get-ADUser -Filter * -Properties OfficePhone

foreach ($user in $users) {
    if ($user.OfficePhone) {
        # Normalize the phone number (example: remove non-digit characters)
        $normalizedPhone = ($user.OfficePhone -replace '[^\d]', '')

        # Format the phone number (example: (123) 456-7890)
        if ($normalizedPhone.Length -eq 10) {
            $formattedPhone = "($($normalizedPhone.Substring(0,3))) $($normalizedPhone.Substring(3,3))-$($normalizedPhone.Substring(6,4))"
        } else {
            $formattedPhone = $user.OfficePhone  # Leave as is if not 10 digits
        }

        # Update the phone number if it has changed
        if ($formattedPhone -ne $user.OfficePhone) {
            Set-ADUser -Identity $user.SamAccountName -OfficePhone $formattedPhone

            # Output the result
            Write-Host "Updated phone number for user $($user.SamAccountName): $formattedPhone"
        }
    }
}

# Output completion message
Write-Host "Attribute normalization complete."
