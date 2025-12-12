Import-Module Microsoft.Graph.DirectoryRoles
Connect-MgGraph -Scopes "Directory.Read.All"

Get-MgDirectoryRole | ForEach-Object {
    $role = $_
    $members = Get-MgDirectoryRoleMember -DirectoryRoleId $_.Id
    foreach ($m in $members) {
        Write-Output "$($role.DisplayName) - $($m.Id)" |
        Out-File RoleAssignments.txt -Append
    }
}
