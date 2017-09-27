# =============================================================================
# 関数名         : RecoverRemotingForAnsible.ps1
# 機能名         : Ansible用のリモート設定を復旧する
# 処理概要       : ShowRemotingForAnsible.ps1 で出力されたconfファイルの情報をもとに、
#                  ConfigureRemotingForAnsible.ps1 で変更されたリモート設定を復旧する。
# バージョン　　 ：Powershell ver4.0で作成。
# 引数1          : 復旧用confファイル
# 戻り値[0]      : 正常終了
# 戻り値[1]      : 異常終了
#
# 備考           : なし
#
# 変更履歴[ver1] : 2015/11/26 TIS矢部 新規作成
#
# ==============================================================================

if ( $args.Length -eq 0 ) {
    Write-Output "復旧用の設定ファイルを引数に指定してください。"
    exit 1
}

$setting_path = $args[0]

# ファイル読み込み
$flag = 0
$lines = Get-Content -Path $setting_path

foreach($line in $lines){
    if($flag -eq 0){
    
        # ＜通常読み込み＞

        # コメントと空行を除外する
        if($line -match "^$"){ continue }
        if($line -match "^\s*$"){ continue }
        if($line -match "^\s*#"){ continue }

        # 「=」の有無確認
        $ret = $line.IndexOf("=")
        if ($ret -eq -1){
            Write-Output "★設定ファイル読み込みエラー★"
            $mes = "設定ファイルを読み時にエラーが発生しました。`r`nパス: "+$param1+"`r`n行: "+$line
            Write-Output $mes
            continue
        }
        # 変数の格納
        $var_name1 = $line.split("=",2)[0]
        $var_value1 = $line.split("=",2)[1]
        $var_value1 = $var_value1.Trim('"')
        if ( $var_value1 -eq '$true' ) {
            $var_value1 = $true
        } elseif ( $var_value1 -eq '$false' ) {
            $var_value1 = $false
        }
        Set-Variable -Name $var_name1 -Value $var_value1
        continue
    }
}


# -----------------------------------------------------------

$ErrorActionPreference = "Stop"

Write-Output "ansible設定の復旧を開始しました。"

### 設定値確認 ###

If (!(Get-Service "WinRM")){
    $ServiceExists_now=$false
} Else {
    $ServiceExists_now=$true
    $StartMode_now=(Get-WmiObject Win32_Service -filter "Name='WinRM'").StartMode
    $State_now=(Get-WmiObject Win32_Service -filter "Name='WinRM'").State
}

If (!(Get-PSSessionConfiguration -Verbose:$false) -or (!(Get-ChildItem WSMan:\localhost\Listener))){
    $PSRemoting_now=$false
} Else {
    $PSRemoting_now=$true
}

$listeners = Get-ChildItem WSMan:\localhost\Listener
If ($listeners | Where {$_.Keys -like "TRANSPORT=HTTPS"}) {
    $SSLListener_now=$true
} Else {
    $SSLListener_now=$false
}

$Basic_now=(Get-ChildItem WSMan:\localhost\Service\Auth | Where {$_.Name -eq "Basic"}).Value
$AllowUnencrypted_now=(Get-ChildItem WSMan:\localhost\Service | Where {$_.Name -eq "AllowUnencrypted"}).Value

If (@(Get-NetFirewallRule | Where-Object {$_.DisplayName -eq "Allow WinRM HTTPS"}).Length -eq 0){
    $AllowWinRMHTTPSExists_now=$false
}Else{
    $AllowWinRMHTTPSExists_now=$true
}



### WinRMサービス設定 ###
if ( ! $ServiceExists ) {
    Write-Output "WinRM サービスが存在しない状態への変更は出来ません"
} Else {
    if ( ( $StartMode -ne $StartMode_now ) -or ( $State -ne $State_now ) ) {
        Set-Service -Name "WinRM" -StartupType $StartMode -Status $State
    }
}

### PSRemoting設定 ###
if ( ( ! $PSRemoting ) -and $PSRemoting_now ) {
    Disable-PSRemoting -Confirm:$False
}

### SSL リスナー設定 ###
if ( ( ! $SSLListener ) -and $SSLListener_now ) {
    $selectorset = @{}
    $selectorset.Add('Transport', 'HTTPS')
    $selectorset.Add('Address', '*')
    Remove-WSManInstance -ResourceURI 'winrm/config/Listener'-SelectorSet $selectorset
}

### WinRM設定 ###
if ( ( ! $Basic ) -and $Basic_now ) {
    Set-Item -Path "WSMan:\localhost\Service\Auth\Basic" -Value $Basic
}
if ( ( ! $AllowUnencrypted ) -and $AllowUnencrypted_now ) {
    Set-Item -Path "WSMan:\localhost\Service\AllowUnencrypted" -Value $AllowUnencrypted
}

### FireWall設定 ###
if ( ( ! $AllowWinRMHTTPSExists ) -and $AllowWinRMHTTPSExists_now ) {
    Remove-NetFirewallRule -DisplayName "Allow WinRM HTTPS"
}

Write-Output "ansible設定の復旧を終了しました。"

exit 0