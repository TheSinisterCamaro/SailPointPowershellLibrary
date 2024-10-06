# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users with phone numbers
$users = Get-ADUser -Filter * -Properties OfficePhone

foreach ($user in $users) {
    if ($user.OfficePhone) {
        # Remove any non-digit characters
        $digitsOnly = ($user.OfficePhone -replace '[^\d]', '')

        # Format the phone number (e.g., +1 (123) 456-7890)
        if ($digitsOnly.Length -eq 10) {
            $formattedPhone = "+1 ($($digitsOnly.Substring(0,3))) $($digitsOnly.Substring(3,3))-$($digitsOnly.Substring(6,4))"
        } elseif ($digitsOnly.Length -eq 11 -and $digitsOnly.StartsWith("1")) {
            $formattedPhone = "+$($digitsOnly.Substring(0,1)) ($($digitsOnly.Substring(1,3))) $($digitsOnly.Substring(4,3))-$($digitsOnly.Substring(7,4))"
        } else {
            $formattedPhone = $user.OfficePhone  # Leave as is if format is unexpected
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
Write-Host "Phone number standardization complete."
