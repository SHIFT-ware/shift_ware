# =============================================================================
# 関数名         : ShowRemotingForAnsible.ps1
# 機能名         : Ansible用のリモート設定を詳細に出力する
# 処理概要       : ConfigureRemotingForAnsible.ps1 で変更されるパラメータを詳細に出力する。
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

Write-Output "＜WinRMサービス設定＞" | Out-File $log_filepath -Append
If (!(Get-Service "WinRM")){
    Write-Output "WinRMサービスが見つかりませんでした" | Out-File $log_filepath -Append
}Else{
    $ret=(Get-WmiObject Win32_Service -filter "Name='WinRM'").StartMode
    Write-Output "自動起動設定：$ret" | Out-File $log_filepath -Append
    $ret=(Get-WmiObject Win32_Service -filter "Name='WinRM'").StartMode
    Write-Output "ステータス：$ret" | Out-File $log_filepath -Append
}

Write-Output "＜PSSession設定＞" | Out-File $log_filepath -Append
Get-PSSessionConfiguration | Out-File $log_filepath -Append

Write-Output "＜リスナー設定＞" | Out-File $log_filepath -Append
Get-ChildItem WSMan:\localhost\Listener | Out-File $log_filepath -Append

Write-Output "＜WinRM設定＞" | Out-File $log_filepath -Append
winrm get winrm/config  | Out-File $log_filepath -Append

Write-Output "＜FireWall設定＞" | Out-File $log_filepath -Append
If (@(Get-NetFirewallRule | Where-Object {$_.DisplayName -eq "Allow WinRM HTTPS"}).Length -eq 0){
    Write-Output "FWルール「Allow WinRM HTTPS」が見つかりませんでした。" | Out-File $log_filepath -Append
}Else{
    Get-NetFirewallRule -DisplayName "Allow WinRM HTTPS" | Out-File $log_filepath -Append
}

Write-Output "ansible設定の出力が完了しました。"

exit 0