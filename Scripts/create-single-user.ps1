Import-Module Microsoft.Graph.Users

Connect-MgGraph -Scopes "User.ReadWrite.All"

$password = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordProfile
$password.Password = "TempPass123!"

New-MgUser -AccountEnabled:$true `
    -DisplayName "Analyst One" `
    -MailNickname "analyst1" `
    -UserPrincipalName "analyst1@gurksingh99gmail.onmicrosoft.com" `
    -PasswordProfile $password `
    -UsageLocation "CA" `
    -ForceChangePasswordNextSignIn:$true
