# SailPoint and Active Directory PowerShell Scripts Library

A comprehensive collection of PowerShell scripts designed to automate and manage tasks within SailPoint IdentityIQ/IdentityNow and Microsoft Active Directory environments.

## Description

This repository contains a wide range of PowerShell scripts specifically crafted for identity and access management (IAM) solutions using SailPoint and Active Directory. These scripts aim to help administrators automate routine tasks, integrate with SailPoint APIs, manage Active Directory objects, and enhance the efficiency of identity management processes.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Scripts Overview](#scripts-overview)
  - [Examples](#examples)
- [Scripts Included](#scripts-included)
  - [SailPoint Scripts](#sailpoint-scripts)
  - [Active Directory Scripts](#active-directory-scripts)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

## Getting Started

### Prerequisites

- **PowerShell 5.1** or higher
- **Git** installed on your local machine
- **SailPoint API Access**: Ensure you have valid API tokens and necessary permissions to interact with SailPoint APIs.
- **Active Directory Module**: For scripts interacting with AD.
  - Install via PowerShell (if not already installed):

    ```powershell
    Install-Module ActiveDirectory
    ```

- **Modules**:
  - Any additional modules required by specific scripts (noted in script comments).

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/TheSinisterCamaro/SailPointPowershellLibrary.git
Navigate to the Directory

    cd SailPointPowershellLibrary
    
Review and Update Scripts
- Open the scripts in your preferred text editor.
- Update any placeholders with your actual API endpoints, tokens, and environment-specific details.
- Ensure that sensitive information like API tokens is securely stored and not hard-coded.

Usage
Scripts Overview
This library includes the following scripts:

SailPoint Scripts
1. Identity Provisioning Script (IdentityProvisioningScript.ps1): Automates the creation of new identities in SailPoint.
2. Identity Deprovisioning Script (IdentityDeprovisioningScript.ps1): Automates the removal of identities.
3. Access Request Script (AccessRequestScript.ps1): Submits access requests for additional entitlements.
4. Certification Campaign Creation Script (CertificationCampaignScript.ps1): Automates the creation of certification campaigns.
5. Role Management Script (RoleManagementScript.ps1): Manages roles and assigns entitlements.
6. Identity Refresh Script (IdentityRefreshScript.ps1): Triggers an identity refresh for all identities.
7. Task Execution Script (TaskExecutionScript.ps1): Executes specific tasks like aggregation or correlation.
8. Identity Attribute Sync Script (IdentityAttributeSyncScript.ps1): Synchronizes identity attributes from external systems.
9. Entitlement Aggregation Script (EntitlementAggregationScript.ps1): Aggregates entitlements from connected applications.
10. Policy Violation Report Script (PolicyViolationReportScript.ps1): Retrieves policy violation reports.

Active Directory Scripts
1. Bulk User Creation Script (BulkUserCreationScript.ps1): Creates multiple user accounts in Active Directory from a CSV file.
2. Group Management Script (GroupManagementScript.ps1): Automates the creation and management of AD groups.
3. Password Expiry Reminder Script (PasswordExpiryReminderScript.ps1): Sends reminders to users whose passwords are about to expire.
4. User Onboarding Notification Script (UserOnboardingNotificationScript.ps1): Notifies relevant teams when a new user is onboarded.
5. Resource Cleanup Script (ResourceCleanupScript.ps1): Removes unused resources like stale computer accounts.
6. License Management Script (LicenseManagementScript.ps1): Manages software licenses in systems like Microsoft 365.
7. Custom Report Generation Script (CustomReportGenerationScript.ps1): Generates reports based on specific criteria.
8. Anomaly Detection Alert Script (AnomalyDetectionAlertScript.ps1): Notifies administrators of unusual activities by analyzing logs.
9. Session Termination Script (SessionTerminationScript.ps1): Terminates user sessions remotely.
10. Service Restart Script (ServiceRestartScript.ps1): Restarts services automatically upon failure.
(Additional scripts are included in the repository.)

Examples
1. Provision New Identities (SailPoint)
Automate the provisioning of new identities from a CSV file.
    ```powershell
    .\IdentityProvisioningScript.ps1 -CsvPath "C:\NewIdentities.csv"

2. Create a Certification Campaign (SailPoint)
Automate the creation of a certification campaign.
    ```powershell
    .\CertificationCampaignScript.ps1

3. Bulk User Creation (Active Directory)
Create multiple AD user accounts from a CSV file.
    ```powershell
    .\BulkUserCreationScript.ps1 -CsvPath "C:\NewADUsers.csv"

4. Send Password Expiry Reminders (Active Directory)
Notify users about upcoming password expirations.

    ```powershell
    .\PasswordExpiryReminderScript.ps1
    
Configuration
- API Credentials: Store your SailPoint API tokens securely.
  - Consider using Windows Credential Manager or secure files.
- Active Directory Access: Ensure you have the necessary permissions to run AD scripts.
- Environment Variables: Set environment variables for common parameters like API URLs.

Scripts Included
SailPoint Scripts
1. IdentityProvisioningScript.ps1
- Automates the provisioning of new identities in SailPoint.
- Parameters:
  - CsvPath: Path to the CSV file containing new user information.

2. IdentityDeprovisioningScript.ps1
- Automates the deprovisioning of identities in SailPoint.
- Parameters:
  - IdentityListPath: Path to the text file containing identities to deprovision.
(Include descriptions for all SailPoint scripts.)

Active Directory Scripts
1. BulkUserCreationScript.ps1
- Creates multiple user accounts in Active Directory from a CSV file.
- Parameters:
  - CsvPath: Path to the CSV file containing user details.

2. GroupManagementScript.ps1
- Automates the creation and management of AD groups.
- Parameters:
  - GroupName: Name of the group to create or manage.
(Include descriptions for all Active Directory scripts.)

Contributing
Contributions are welcome! If you'd like to contribute to this repository, please follow these steps:
1. Fork the Repository
- Click on the Fork button at the top right corner of the repository page.
2. Clone Your Fork
    ```bash
    git clone https://github.com/YourUsername/SailPointPowershellLibrary.git
3. Create a Feature Branch
    ```bash
    git checkout -b feature/YourFeatureName
4. Make Your Changes
- Add new scripts or enhance existing ones.
- Ensure your code follows the project's coding standards.
- Update the README.md if necessary.
5. Commit Your Changes
    ```bash
    git commit -am "Add new feature: YourFeatureName"
6. Push to Your Fork
    ```bash
    git push origin feature/YourFeatureName
7. Open a Pull Request
- Go to your fork on GitHub.
- Click on Compare & pull request.
- Provide a clear description of your changes.
- Submit the pull request for review.

License
This project is licensed under the MIT License. You are free to use, modify, and distribute this software in accordance with the license terms.

Contact
Raymond Dickerson
Email: jdickerson2477@yahoo.com
GitHub: TheSinisterCamaro
Feel free to reach out if you have any questions or need assistance.

Acknowledgments
- SailPoint Community: For providing excellent resources and support.
- Microsoft Docs: For comprehensive documentation on Active Directory.
- Contributors: Thanks to everyone who has contributed to this project.

Additional Notes
- Security Reminder: Ensure that all sensitive information such as API tokens, passwords, and personal data are handled securely. Do not commit such information to the repository.
- Testing: Always test scripts in a development or staging environment before deploying them to production.
- Feedback: Your feedback is valuable. If you encounter any issues or have suggestions for improvements, please open an issue on GitHub.

Disclaimer
This project is provided "as is" without warranty of any kind. The authors are not responsible for any damages or data loss resulting from the use of these scripts. Use at your own risk.
