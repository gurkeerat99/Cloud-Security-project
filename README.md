# 🔐 Azure Entra ID Security Hardening Project (Zero Trust | IAM | MFA | RBAC)
This project demonstrates my hands-on experience with Azure Entra ID security including 
identity protection, MFA enforcement, Conditional Access Zero Trust policies, RBAC design, and 
secure authentication governance. It reflects a real-world cloud security engineer workflow.

PROJECT 1 – Azure Identity & Access Security Hardening

1. User Provisioning & Access Setup
1.1 Created Initial Admin Accounts

Using Azure Portal → Azure Entra ID → Users:
* `FirstUser` (test user)
* `GlobalAdministrator` (core admin)
<img width="1918" height="850" alt="Created account Analyst one using powershell" src="https://github.com/user-attachments/assets/12a5b1b0-3b67-4b72-babb-4e5ffcf19a0b" />

Purpose:
Establish a foundational identity store before automation.

2. Automated User Creation (PowerShell + Microsoft Graph API)
2.1 Issue Encountered

Attempted to run Graph commands using my Gmail account, which has no Entra privileges.
Solution: Switched to Global Administrator account → PowerShell worked successfully.

2.2 Installing & Connecting to Microsoft Graph (Step 1)
Purpose:
Install official Microsoft Graph PowerShell SDK and authenticate with proper permissions.

2.3 Creating a Single User (Step 2)

powershell
$password = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordProfile
$password.Password = "TempPass123!"

New-MgUser -AccountEnabled:$true `
    -DisplayName "Analyst One" `
    -MailNickname "analyst1" `
    -UserPrincipalName "analyst1@gurksingh99gmail.onmicrosoft.com" `
    -PasswordProfile $<nottellanyone>`
    -UsageLocation "CA" `
    -ForceChangePasswordNextSignIn:$true
<img width="836" height="822" alt="Powershell Script for analystOne" src="https://github.com/user-attachments/assets/c13d65ff-88e5-401b-b921-374714ce282e" />

2.4 Bulk-Created 8 Users Using a Custom Script

All users were created with:

* Temporary passwords
* Canada usage location
* Force password change at next sign-in

Purpose:
Simulate a real organization’s identity lifecycle automation.
<img width="1308" height="1002" alt="3  Creating 8 users with powershell" src="https://github.com/user-attachments/assets/b14e969c-caa3-4cec-8c5a-d0a681039844" />

3. Role-Based Access Control (RBAC) – Group & Role Structure

3.1 Created Security Groups
A) CloudSec-Admins
Purpose: Centralized role assignment for privileged accounts.
Members:
`globaladmin1`
`securityadmin1`
`useradmin1`
`compliance1`
<img width="1918" height="923" alt="5  Cloudsecadmin group" src="https://github.com/user-attachments/assets/cc1bce9d-3bc3-42eb-ad20-c2e22a72cabf" />

B) Analyst-Team

Purpose: Regular users grouped for future CA & resource access policies.
Members:
`analyst1`
`manager1`
`testuser1`
<img width="1918" height="945" alt="6  Analyst Group" src="https://github.com/user-attachments/assets/6cf0ca3a-3287-4d99-815b-e1389155fe8b" />

3.2 Role Assignments (Least Privilege)

 User            Role Assigned            
-------------- ------------------------ 
 globaladmin1   Global Administrator   
 securityadmin1 Security Administrator 
 useradmin1     User Administrator     
 compliance1    Compliance Administrator
 analyst1       None (Standard user)     
 manager1       None                     
 testuser1      None                     
 guestuser1     None                     

Purpose:
Enforce Least Privilege Access (LPA) following Microsoft Zero Trust principles. Let's go.
<img width="1915" height="702" alt="7  Roles and administrator" src="https://github.com/user-attachments/assets/ba5cc495-4ede-4390-a765-f251ab590ec6" />

4. MFA Enforcement & Licensing Setup

4.1 MFA Enabled by Default
Due to Microsoft’s new September 2025 enforcement, MFA is automatically enforced for:
* All users
* All portals
* All sign-ins

Verified MFA prompts for:

* securityadmin1
* testuser1

4.2 Activated Entra ID P2 Managed Trial
This unlocked:
* Conditional Access
* Identity Protection
* Privileged Identity Management (PIM)
* Sign-in Risk Policies
* User Risk Policies

Then P2 license assigned to all lab users.
<img width="1912" height="907" alt="9  Assigning P2 License to all the users" src="https://github.com/user-attachments/assets/d5d418c1-d714-4266-9497-65ee263a713b" />

Purpose:
Enable enterprise-grade identity security features.

5. Conditional Access Policies (Zero Trust Controls)

5.1 CA Policy #1 – Require MFA for CloudSec-Admins

Users: CloudSec-Admins group
Apps: All cloud apps
Conditions: None
Grant: Require MFA
Status: Enabled

Tested:
securityadmin1 → Sign-in triggered immediate MFA → Verified working.

Purpose:
Enforce MFA for all privileged identities.
<img width="1918" height="958" alt="10  MFA policy overview for Cloud admins" src="https://github.com/user-attachments/assets/16c662e0-9ca2-437a-b6d1-d61aec9d54b3" />

5.2 Conditional Access Policy: Block Non-Canada Sign-ins
Steps: Create CA Policy

Users: All users
Exclude: CloudSec-Admins
Conditions = Locations:

Include: All locations
Exclude: *Canada Only*

Grant: Block access
Status: Enabled
### Testing & Fixes

* securityadmin1 was initially blocked → root cause: missing exclusion
* Fixed by excluding CloudSec-Admins
* Tested using VPN (Chicago, US) → login blocked for normal users
* Admin users allowed

Purpose:
Prevent global intrusion attempts while allowing secure admin maintenance.
<img width="1908" height="950" alt="11  Canada Only Sign-ins policy" src="https://github.com/user-attachments/assets/25fcba30-5bc8-4c97-8124-21e3830ec4a9" />
<img width="1428" height="847" alt="13 1 Blocked access" src="https://github.com/user-attachments/assets/0caec9e7-dd45-42c1-9285-767608b274e7" />


6. Identity Protection (User Risk + Sign-in Risk)
6.1 Generated Risky Activity
Used VPN (Chicago) + wrong passwords → triggered:

* Location anomaly detection
* Suspicious sign-in activity
* Risk state = At risk
* Risk level = Medium

Logs validated in:

* Identity Protection → Risky users
* Risky sign-ins
* Conditional Access sign-in logs

### Actions Taken:

* Reviewed risky user details
* Performed remediation
* Verified CA enforcement

Purpose:
Simulate real-world compromised account detection & automated remediation.
<img width="855" height="598" alt="15 risky user with the policy" src="https://github.com/user-attachments/assets/4061671d-d975-4de7-97f1-7a0e46766fcd" />

This project overview

## 📝 Summary
This project strengthened identity security posture by implementing Zero Trust controls,
enhanced MFA enforcement, RBAC governance, and identity threat detection. It simulates 
what a Cloud Security Engineer would configure in a real Azure environment.


## 🚀 Next Steps
- Integrate Azure Identity logs with Microsoft Sentinel
- Deploy Privileged Identity Management (PIM)
- Automate user provisioning using PowerShell / Graph API
- Add detection rules for risky sign-ins
- Add CIEM analysis for role cleanup

