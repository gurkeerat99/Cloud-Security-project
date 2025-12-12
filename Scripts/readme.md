This directory contains automation scripts used to provision users, assign licenses,
and manage roles in an Azure Entra ID tenant.

Scripts included:
- create-single-user.ps1 → Creates a single Entra ID user.
- bulk-user-creation.ps1 → Bulk creates user accounts from CSV.
- assign-licenses.ps1 → Assigns P2 licenses automatically.
- list-role-assignments.ps1 → Exports RBAC role assignments.

All scripts use the Microsoft Graph PowerShell SDK.
