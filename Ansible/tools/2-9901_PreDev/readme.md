# ToolName : 2-9901_PreDev

---------------

## Synopsis
- SHIFT wareを実行するにあたり、ターゲット側に必要となる設定をします。
- 2-9901_PreDev実行後は以下の状態になります。
  - コントロールマシンからWinRMでターゲットに接続可能となります。
  - Windowsのrole実行に必要なexeファイルがターゲットに配置されます。
  - Hotfix（KB2842230）がターゲットに適用されます。(Win2012のみが対象、Ansibleの実行要件のため)
- この設定をもとに戻すには2-9902_PostDevを利用できます。

## Tested platforms

platform | ver | 
-------- |---|
WindowsServer|2012
WindowsServer|2012R2
  
## Tasks
- WinRMの有効化(ターゲット側で手動実行)
- 一時ディレクトリの作成
- 各種ファイルの送付
- Hotfix適用、ターゲットの再起動(Win2012のみ)

## Usage 
### How to set inventory
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

### How to run
1. 実行に必要なファイルをリポジトリ内に集めます。以下の手順を実施します。
  1. Powershellスクリプト「ConfigureRemotingForAnsible.ps1」をダウンロードし、`Ansible/tools/2-9901_PreDev/PSscripts`に配置します。コントロールマシンがインターネットにアクセスできる場合、以下のコマンドが利用可能です。

        ```
        # curl -o Ansible/tools/2-9901_PreDev/PSscripts/ConfigureRemotingForAnsible.ps1 https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1

        ```

  1. Windowsマシンにて[https://gallery.technet.microsoft.com/Hyper-V-Network-VSP-Bind-cf937850](https://gallery.technet.microsoft.com/Hyper-V-Network-VSP-Bind-cf937850)からEXEファイル「Microsoft_Nvspbind_package.EXE」をダウンロードし、実行します。展開されたファイル「nvspbind.exe」をコントロールマシンの`Ansible/tools/2-9901_PreDev/files`に配置します。

  1. Windowsマシンにて[http://support.microsoft.com/kb/2842230](http://support.microsoft.com/kb/2842230)からファイル「Windows8-RT-KB2842230-x64.msu」をダウンロードし、`Ansible/tools/2-9901_PreDev/files`に配置します。

1. ターゲットマシンにて以下の手順を行います。Predev実行対象の全ターゲットにて実施が必要です。
  1. リポジトリの以下フォルダをターゲットの任意の場所にコピーします。
  
        ```
        Ansible/tools/2-9901_PreDev/PSscripts
        ```
    
  1. VMのクローンなどでsysprepを実施している場合は以下のスクリプトを「右クリック>Powershellで実行」します。
  
        ```
        PSscripts\RemoveListener.ps1
        ```

  1. 以下のスクリプトを「右クリック>Powershellで実行」します。
  
        ```
        PSscripts\ShowRemotingForAnsible.ps1
        ```

  1. 上記ShowRemotingForAnsible.ps1を実行すると以下の設定バックアップファイルが出力されます。SHIFT ware実行後の事後作業（PostDev）で使用しますので、削除しないでください.
  
  
        ```
        C:\temp\ansible_winrm_setting_YYYY-MM-DD@HH-MM-SS~.conf
        ```
 
  1. 以下のスクリプトを「右クリック>Powershellで実行」します。

        ```
        PSscripts\ConfigureRemotingForAnsible.ps1
        ```

1. コントロールマシンにて、以下のコマンドを実行します。

  ```
  # Shift_Bin/tools/2-9901_PreDev.sh run
  ```

## Dependencies
- none

## Caution
- 本ツールの実行により、ターゲットが再起動される場合があります。
