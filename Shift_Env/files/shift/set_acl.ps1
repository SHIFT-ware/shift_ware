$path=$args[0]
$user=$args[1]
$rights=$args[2]
$inherit_str=$args[3]
$type=$args[4]

if (!(Test-Path -Path $path)){
  Write-Host "ÉpÉXÇ™ë∂ç›ÇµÇ‹ÇπÇÒ: Path='$path'"
  exit 1
}

if ($inherit_str.Contains("thisfolder")) {
    $propagation = "None"
} else {
    $propagation = "InheritOnly"
}

$inherit = ""
if ($inherit_str.Contains("subfolder")) {
    $inherit += "ContainerInherit, "
}
if ($inherit_str.Contains("file")) {
    $inherit += "ObjectInherit, "
}
if ($inherit -eq ""){
    $inherit = "None"
}
$inherit = $inherit.Trim(", ")

$acl = Get-Acl $path
$acl.SetAccessRuleProtection($True,$True)
Set-Acl $path -AclObject $acl

$account = New-Object System.Security.Principal.NTaccount ($user)
$acl = Get-Acl $path
$acl.PurgeAccessRules($account)
Set-Acl $path -AclObject $acl

$aclparam = @($user, $rights, $inherit, $propagation, $type)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule $aclparam
$acl = Get-Acl $path
$acl.AddAccessRule($rule)
Set-Acl $path -AclObject $acl

exit 0
