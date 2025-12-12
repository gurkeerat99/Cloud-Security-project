Import-Module Microsoft.Graph.Users
Connect-MgGraph -Scopes "User.ReadWrite.All"

$users = Import-Csv ".\users.csv"

foreach ($user in $users) {
    $pass = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordProfile
    $pass.Password = $user.Password

    New-MgUser -AccountEnabled:$true `
        -DisplayName $user.DisplayName `
        -MailNickname $user.MailNickname `
        -UserPrincipalName "$($user.MailNickname)@gurksingh99gmail.onmicrosoft.com" `
        -PasswordProfile $pass `
        -UsageLocation "CA" `
        -ForceChangePasswordNextSignIn:$true

    Write-Host "Created user: $($user.DisplayName)"
}
