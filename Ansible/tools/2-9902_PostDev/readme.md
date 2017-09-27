# ToolName : 2-9902_PostDev

---------------

## Synopsis
- 2-9901_PreDevの実行を前提とし、この実行時の設定変更を元に戻します。
  
## Tested platforms

platform | ver | 
-------- |---|
WindowsServer|2012
WindowsServer|2012R2

## Tasks
- 一時ディレクトリの削除
- PreDevで適用したHotfixの削除、ターゲットの再起動(Win2012のみ)
- WinRMの設定をPreDev実行前に戻す(ターゲット側で手動実行)

## Usage 
### How to set parameter （Shift_Env)
本ツールはロール実行時のインベントリファイルとは別に専用のインベントリファイルが必要です。以下のファイル名で記載例に従って作成してください。なお、ファイル名
が規則に従っていれば複数のファイルに分割して記載も可能です。この場合、ファイル内の各ターゲットに対してツールは並列実行され、全ターゲットに対し実行が終わると
次のファイル内の各ターゲットに対しツール実行が行われます。

- Shift_Env/tools/2-9901_PreDev.{任意の文字列}.inventory

記載例:
```
[targethost]
192.168.127.30  ansible_user=Administrator  ansible_ssh_pass=password
192.168.127.40  ansible_user=Administrator  ansible_ssh_pass=password

[targethost:vars]
ansible_ssh_port = 5986
ansible_connection = winrm
ansible_winrm_server_cert_validation = ignore

#全台共通の場合はここに記載
#ansible_ssh_pass=password
```

### How to run（Shift_Bin)
1. コントロールマシンにて、以下のコマンドを実行します。

  ```
  # Shift_Bin/tools/2-9902_PostDev.sh run
  ```

1. ターゲットマシンにて以下の手順を行います。Predev実行対象の全ターゲットにて実施が必要です。
  1. リポジトリの以下フォルダをターゲットの任意の場所にコピーします。

        ```
        ${SHIFTリポジトリのトップディレクトリ}/Ansible/tools/2-9902_PostDev/PSscripts
        ```

  1. Windows PowerShellを開き、以下のコマンドを実行します。

        ```
        > cd {PSscripts配置先}
        > .\RecoverRemotingForAnsible.ps1 {PreDevのShowRemotingForAnsible.ps1で出力されたconfファイル}

        #実行例
        > RecoverRemotingForAnsible.ps1 C:\temp\ansible_winrm_setting_2016-12-20@12-50-13~.conf
        ```

  1. 以下のスクリプトを「右クリック>Powershellで実行」すると、WinRMの設定をファイルに出力できます。出力場所、ファイル名はPreDevと同じです。必要に応じて確認してください。

        ```
        PSscripts\ShowRemotingForAnsible_all.ps1
        ```
## Dependencies
- none

## Caution
- 本ツールの実行により、ターゲットが再起動される場合があります。
