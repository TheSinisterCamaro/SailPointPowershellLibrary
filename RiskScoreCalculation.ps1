# Import the Active Directory module
Import-Module ActiveDirectory

# Get all active users
$users = Get-ADUser -Filter { Enabled -eq $true } -Properties LastLogonDate, PasswordLastSet, MemberOf

# Initialize an array to store risk scores
$riskScores = @()

foreach ($user in $users) {
    # Initialize risk score
    $riskScore = 0

    # Time since last logon
    $daysSinceLastLogon = (Get-Date - $user.LastLogonDate).Days
    if ($daysSinceLastLogon -gt 90) {
        $riskScore += 2
    }

    # Time since last password change
    $daysSincePwdChange = (Get-Date - $user.PasswordLastSet).Days
    if ($daysSincePwdChange -gt 90) {
        $riskScore += 2
    }

    # Check for membership in high-risk groups
    $highRiskGroups = @("Domain Admins", "Enterprise Admins")
    $userGroups = $user.MemberOf | ForEach-Object { (Get-ADGroup $_).Name }

    if ($userGroups | Where-Object { $highRiskGroups -contains $_ }) {
        $riskScore += 5
    }

    # Compile risk score data
    $riskScores += [PSCustomObject]@{
        UserName         = $user.SamAccountName
        RiskScore        = $riskScore
        LastLogonDate    = $user.LastLogonDate
        PasswordLastSet  = $user.PasswordLastSet
        HighRiskGroup    = ($userGroups | Where-Object { $highRiskGroups -contains $_ }) -join ", "
    }
}

# Export risk scores to a CSV file
$riskScores | Export-Csv -Path "C:\Reports\UserRiskScores.csv" -NoTypeInformation

# Output completion message
Write-Host "Risk score calculation completed."
