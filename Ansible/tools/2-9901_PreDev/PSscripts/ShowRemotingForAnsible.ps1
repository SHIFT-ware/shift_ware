# =============================================================================
# 関数名         : ShowRemotingForAnsible.ps1
# 機能名         : Ansible用のリモート設定をconf形式で出力する
# 処理概要       : ConfigureRemotingForAnsible.ps1 で変更されるパラメータを、key=value形式で出力する
# バージョン　　 ：Powershell ver4.0で作成。
# 引数1          : なし
# 戻り値[0]      : 正常終了
# 戻り値[1]      : 異常終了
#
# 備考           : なし
#
# 変更履歴[ver1] : 2015/11/26 TIS矢部 新規作成
#
# ==============================================================================

# ログファイル出力先設定
Param (
    [string]$log_filepath = "C:\temp\ansible_winrm_setting_"+$([DateTime]::Now.ToString('yyyy-MM-dd@hh-mm-ss~'))+".conf"
)

# -----------------------------------------------------------

$ErrorActionPreference = "Stop"


# ログファイル出力先フォルダ確認
$log_dirpath = Split-Path $log_filepath -Parent
if ( ! ( Test-Path $log_dirpath ) ) {
    Write-Output "ログ出力先フォルダが存在しませんでした。"
    Write-Output "Path: $log_dirpath"
    exit 1
}

Write-Output "ansible設定の出力を開始しました。"

Write-Output "`#`#`# WinRMサービス設定 `#`#`#" | Out-File $log_filepath -Append
If (!(Get-Service "WinRM")){
    Write-Output "ServiceExists=`$false" | Out-File $log_filepath -Append
} Else {
    Write-Output "ServiceExists=`$true" | Out-File $log_filepath -Append
    $ret=(Get-WmiObject Win32_Service -filter "Name='WinRM'").StartMode
    Write-Output "StartMode=`"$ret`"" | Out-File $log_filepath -Append
    $ret=(Get-WmiObject Win32_Service -filter "Name='WinRM'").State
    Write-Output "State=`"$ret`"" | Out-File $log_filepath -Append
}

Write-Output "`r`n`#`#`# PSRemoting設定 `#`#`#" | Out-File $log_filepath -Append
If (!(Get-PSSessionConfiguration -Verbose:$false) -or (!(Get-ChildItem WSMan:\localhost\Listener))){
    Write-Output "PSRemoting=`$false" | Out-File $log_filepath -Append
} Else {
    Write-Output "PSRemoting=`$true" | Out-File $log_filepath -Append
}

Write-Output "`r`n`#`#`# SSL リスナー設定 `#`#`#" | Out-File $log_filepath -Append
$listeners = Get-ChildItem WSMan:\localhost\Listener
If ($listeners | Where {$_.Keys -like "TRANSPORT=HTTPS"}) {
    Write-Output "SSLListener=`$true" | Out-File $log_filepath -Append
} Else {
    Write-Output "SSLListener=`$false" | Out-File $log_filepath -Append
}

Write-Output "`r`n`#`#`# WinRM設定 `#`#`#" | Out-File $log_filepath -Append

$ret = (Get-ChildItem WSMan:\localhost\Service\Auth | Where {$_.Name -eq "Basic"}).Value
Write-Output "Basic=`$$ret" | Out-File $log_filepath -Append

$ret = (Get-ChildItem WSMan:\localhost\Service | Where {$_.Name -eq "AllowUnencrypted"}).Value
Write-Output "AllowUnencrypted=`$$ret" | Out-File $log_filepath -Append


Write-Output "`r`n`#`#`# FireWall設定 `#`#`#" | Out-File $log_filepath -Append
If (@(Get-NetFirewallRule | Where-Object {$_.DisplayName -eq "Allow WinRM HTTPS"}).Length -eq 0){
    Write-Output "AllowWinRMHTTPSExists=`$false" | Out-File $log_filepath -Append
}Else{
    Write-Output "AllowWinRMHTTPSExists=`$true" | Out-File $log_filepath -Append
}

Write-Output "ansible設定の出力が完了しました。"

exit 0