Import-Module Microsoft.Graph.Users
Connect-MgGraph -Scopes "User.ReadWrite.All"

$license = Get-MgSubscribedSku | Where-Object SkuPartNumber -eq "AAD_PREMIUM_P2"

$users = Get-MgUser -All

foreach ($u in $users) {
    Set-MgUserLicense -UserId $u.Id -AddLicenses @{SkuId = $license.SkuId} -RemoveLicenses @()
    Write-Host "Assigned P2 license to $($u.DisplayName)"
}
