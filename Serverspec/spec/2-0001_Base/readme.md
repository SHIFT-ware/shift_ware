# RoleName : 2-0001_Base

---------------

## Synopsis
Windows OSのOS設定が正しく行われているかテストします。

## Tested platforms

platform | ver | 
-------- |-----|
WindowsServer|2012
WindowsServer|2012R2

## Tasks
- ハードウェアのテスト
    - メモリのテスト
        - 仮想メモリの確認
- ユーザ/グループのテスト
    - ユーザのテスト
        - ユーザの存在確認
        - 所属グループの確認
        - アカウント無効化有無の確認
        - パスワード変更可能有無の確認
        - パスワード期限有無の確認
    - グループのテスト
        - グループの存在確認
    - ユーザアカウント制御(UAC)のテスト
        - レベルの確認
- OSコア機能のテスト
    - OSバージョンのテスト
    - タイムゾーンのテスト
    - 起動と回復のテスト
        - 起動時の既定OSの確認
        - OS一覧表示時間の確認
        - クラッシュ時イベントログ書き込み有無確認
        - クラッシュ時自動再起動確認
        - ダンプファイル確認
            - ダンプファイルの種類
            - ファイルパス
            - 上書き有無
- ストレージのテスト
    - ディスクのテスト
        - ディスクの存在確認
        - パーティションスタイルの確認
        - パーティションサイズ(GiB)の確認
    - ボリュームのテスト
        - ドライブ文字の確認
        - ファイルシステムの確認
        - アロケーションユニットサイズの確認
        - ボリュームラベルの確認
        - ボリュームサイズの確認
        - ファイルシステムの圧縮有無の確認
	- CDドライブのテスト
		- ドライブ文字の確認
	- ディレクトリのテスト
		- ディレクトリの存在確認
		- 所有者の確認
		- アクセス制御リスト(ACL)のテスト
			- 権限の確認
			- 適用先(継承設定)の確認
	- コンピュータ名のテスト
	- 所属するグループのテスト
		- ドメイン/ワークグループの確認
		ドメイン名/ワークグループ名の確認
- ネットワークのテスト
	- ネットワークインターフェースのテスト
		- インターフェース名の確認
		- DHCP有効/無効の確認
		- IPアドレスの確認
		- サブネットマスク長(bit)の確認
		- NetBIOS over TCP/IPの有効確認
		- 状態(有効/無効)の確認
	- チーミング(LBFO)のテスト
		- チームの存在確認
		- チーミングモードの確認
		- 負荷分散アルゴリズムの確認
		- 所属する物理NICのテスト
			- インターフェース名の確認
			- Actice/Standbyの確認
		- 所属する論理NICのテスト
			- インターフェース名の確認
			- VLAN IDの確認
	- デフォルトゲートウェイの確認
	- スタティックルートのテスト
		- 宛先ネットワークの確認
		- サブネットマスクの確認
		- ゲートウェイの確認
	- 名前解決のテスト
		- hostsレコードのテスト
			- IPアドレスの確認
			- ホスト名の確認
		- DNSサーバーのテスト
			- 紐付けるインターフェース名の確認
			- DNSサーバーのテスト
				- IPアドレスの確認
	- ファイアーウォールのテスト
		- ドメイン プロファイルのテスト
			- 有効/無効の確認
		- プライベート プロファイルのテスト
			- 有効/無効の確認
		- パブリック プロファイルのテスト
			- 有効/無効の確認
	- IPv6無効化設定のテスト
		- nvspbind.exe のパスの確認
		- レジストリからの無効化の確認
		- NICのプロパティからの無効化の確認
		- netshコマンドからの無効化のテスト
			- isatapインターフェースの確認
			- 6to4インターフェースの確認
			- teredoインターフェースの確認
	- DNSサフィックスのテスト
		- プライマリDNSサフィックスのテスト
			- FQDNの確認
			- ドメインのメンバシップに連動の確認
		- 全DNSサフィックスのテスト
			- FQDNの確認
- OSアドバンスド機能のテスト
	- 組織名の確認
	- 使用者名の確認
	- リモートデスクトップ接続の確認
	- サービスのテスト
		- サービス名の確認
		- 実行状態の確認
		- スタートアップの種類の確認
		- 遅延開始フラグの確認
		- トリガー開始フラグの確認
	- 役割と機能のテスト
		- 名前(フルパス)の確認
	- イベントログのテスト
		- アプリケーションのテスト
			- ログのパスの確認
			- ローテーション設定の確認
			- 最大サイズ(KB)の確認
		- セキュリティのテスト
			- ログのパスの確認
			- ローテーション設定の確認
			- 最大サイズ(KB)の確認
		- システム情報のテスト
			- ログのパスの確認
			- ローテーション設定の確認
			- 最大サイズ(KB)の確認
	- プログラムと機能
		- プログラム名の確認
		- プログラム名の確認
	- 更新プログラム(hotfix)
		- KB番号(hotfix ID)の確認
	- レジストリ
		- キーの確認
		- 値のテスト
			- 名前の確認
			- 種類の確認
			- データの確認
	- Windows エラー報告の確認
	- Windows Updateの確認
	- Powershell 実行ポリシー(ComputerScope)の確認
	- SNMP サービス設定のテスト
		- トラップのテスト
			- コミュニティのテスト
			    - コミュニティ名の確認
				- トラップ送信先のテスト
                - IPアドレス・ホスト名の確認
		- セキュリティのテスト
			- 認証トラップ送信の確認
			- トラップ許可のテスト
				- コミュニティのテスト
                - コミュニティ名の確認
                - 権限の確認
				- ホストのテスト
                - IPアドレス・ホスト名の確認

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
#---------------
  BASE:                                   #BASE
#---------------
    HW:                                   #ハードウェア
      memory:                             #メモリ
        virtualmemory:                    #仮想メモリ(ページファイル)
          type: 'auto'                    #種類
          size:                           #サイズ(Customのみ)
            min: 4096                     #初期サイズ
            max: 4096                     #最大サイズ
    ID:                                   #ユーザアカウント
      user:                               #ユーザ
        - name: 'Administrator'           #ユーザ名
          groups: 'Administrators'        #所属グループ
          disabled_flag: 'False'          #アカウント無効化フラグ
          changeable_pass_flag: 'True'    #パスワード変更可能フラグ
          pass_expires_flag: 'True'       #パスワード期限付きフラグ
        - name: 'testuser'                #ユーザ名
          groups: 'Users'                 #所属グループ
          disabled_flag: 'False'          #アカウント無効化フラグ
          changeable_pass_flag: 'False'   #パスワード変更可能フラグ
          pass_expires_flag: 'False'      #パスワード期限付きフラグ
      group:                              #グループ
        - name: 'Administrators'          #名前
        - name: 'Users'                   #名前
      uac:                                #ユーザアカウント制御
        level: 'low'                      #レベル
    OSCORE:                               #OSコア設定
      systeminfo:                         #システム情報
        os_name: 'Microsoft Windows Server 2012 Standard'     #OSバージョン
      timezone: 'Tokyo Standard Time'     #タイムゾーン
      recover_os:                         #起動と回復
        default_os_version: 'Windows Server 2012'             #既定のOS
        display_os_list_time: 30          #OS一覧表示時間(秒)
        write_eventlog: True              #イベントログ書込み
        auto_reboot: True                 #自動再起動
        dumpfile:                         #ダンプファイル
          type: 'auto'                    #種類
          path: 'C:\Windows\MEMORY.DMP'   #ファイルパス
          overwrite: True                 #上書き
#---------------
  STORAGE:                                #STORAGE
#---------------
    disk:                                 #ディスク
      - number: 0                         #ディスク番号
        partition_style: 'MBR'            #パーティションの種別
        total_size: 50                    #ディスクサイズ(GiB)
        partition:                        #ボリューム
          - drive_letter: 'C'             #ドライブ文字
            filesystem: 'NTFS'            #ファイルシステム
            au_size: 4096                 #アロケーションユニットサイズ
            size: 50                      #ボリュームサイズ(GiB)
            archive: 'False'              #ファイルシステムの圧縮
    cdrom:                                #CDドライブ
      - drive_letter: 'D'                 #ドライブ文字
    directory:                            #ディレクトリ
      - path: 'C:\temp'                   #パス
        owner: 'BUILTIN\Administrators'   #所有者
        acl:                              #アクセス制御リスト(ACL)
          - user: 'BUILTIN\Users'         #対象ユーザ/グループ
            rights: 'Read, Synchronize'   #権限
            type: 'Allow'                 #許可/拒否
            inherit: 'thisfolder, subfolder, file'             #適用先(複数選択化)
          - user: 'testuser'              #対象ユーザ/グループ
            rights: 'FullControl'         #権限
            type: 'Allow'                 #許可/拒否
            inherit: 'thisfolder'         #適用先(複数選択化)
#---------------
  NETWORK:                                #NETWORK
#---------------
    hostname: 'target30'                  #コンピュータ名
    domain:                               #所属するグループ
      type: 'workgroup'                   #ドメイン/ワークグループ
      name: 'WORKGROUP'                   #ドメイン名/ワークグループ名
    eth:                                  #ネットワークインターフェース
      - name: 'イーサネット'              #インターフェース名
        dhcp: False                       #DHCP有効/無効
        ipaddress: '192.168.127.30'       #IPアドレス
        prefix: 24                        #サブネットマスク長(bit)
        netbios: 'dhcp'                   #NetBIOS over TCP/IP
        status: 'Up'                      #状態(有効/無効)
      - name: 'teamnic1'                  #インターフェース名
        dhcp: True                        #DHCP有効/無効
        netbios: 'dhcp'                   #NetBIOS over TCP/IP
        status: 'Up'                      #状態(有効/無効)
      - name: 'teamnic2'                  #インターフェース名
        dhcp: True                        #DHCP有効/無効
        netbios: 'dhcp'                   #NetBIOS over TCP/IP
        status: 'Up'                      #状態(有効/無効)
      - name: 'イーサネット 2'            #インターフェース名
        status: 'Up'                      #状態(有効/無効)
      - name: 'イーサネット 3'            #インターフェース名
        status: 'Up'                      #状態(有効/無効)
    teaming:                              #チーミング(LBFO)
      - name: 'team1'                     #チーム名
        mode: 'SwitchIndependent'         #チーミングモード
        lb_mode: 'TransportPorts'         #負荷分散アルゴリズム
        physical_member:                  #所属する物理NIC
          - name: 'イーサネット 2'        #インターフェース名
            mode: 'Active'                #Actice/Standby
          - name: 'イーサネット 3'        #インターフェース名
            mode: 'Standby'               #Actice/Standby
        logical_member:                   #所属する論理NIC
          - name: 'teamnic1'              #インターフェース名
          - name: 'teamnic2'              #インターフェース名
            vlan_id: 10                   #VLAN ID
    default_gw: '192.168.127.254'         #デフォルトゲートウェイ
    static_routing:                       #スタティックルート
      - dest: '192.168.0.0'               #宛先ネットワーク
        mask: '255.255.255.0'             #サブネットマスク
        gw: '192.168.127.254'             #ゲートウェイ
      - dest: '192.168.1.0'               #宛先ネットワーク
        mask: '255.255.255.0'             #サブネットマスク
        gw: '192.168.127.254'             #ゲートウェイ
    name_resolve:                         #名前解決
      hosts_records:                      #hostsレコード
        - ip: '192.168.127.10'            #IPアドレス
          hostname: 'target10'            #ホスト名
        - ip: '192.168.127.20'            #IPアドレス
          hostname: 'target20'            #ホスト名
      dns_server:                         #DNSサーバー
        nic_name: 'teamnic1'              #紐付けるインターフェース名
        server:                           #DNSサーバー
          - ip: '192.168.127.254'         #IPアドレス
          - ip: '127.0.0.1'               #IPアドレス
    firewall:                             #ファイアーウォール
      domain:                             #ドメインプロファイル
        enabled_flag: 'True'              #有効/無効
      private:                            #プライベートプロファイル
        enabled_flag: 'True'              #有効/無効
      public:                             #パブリックプロファイル
        enabled_flag: 'True'              #有効/無効
    ipv6:                                 #IPv6無効化設定
      nvspbind_path: 'C:\.shift\nvspbind.exe'                  #nvspbind.exe のパス
      registry: 'disabled'                #レジストリからの無効化
      nic_property: 'disabled'            #NICのプロパティからの無効化
      netsh_command:                      #netshコマンドからの無効化
        isatap_if: 'disabled'             #isatapインターフェース
        sixtofour_if: 'disabled'          #6to4インターフェース
        teredo_if: 'disabled'             #teredoインターフェース
    dns_suffix:                           #DNSサフィックス
      primary:                            #プライマリDNSサフィックス
        fqdn: 'tistest.local'             #FQDN
        change_when_domain_membership_changed: True            #ドメインのメンバシップに連動
      all:                                #全DNSサフィックス
        - fqdn: 'tistest.local'           #FQDN
#---------------
  ADVANCED:                               #ADVANCED
#---------------
    organization: 'TIS'                   #組織名
    owner: 'TIS'                          #使用者名
    rdp: 'enabled'                        #リモートデスクトップ接続
    service:                              #サービス
      - name: 'DHCP Client'               #サービス名
        state: True                       #実行状態
        start_mode: 'Auto'                #スタートアップの種類
        delay_flag: False                 #遅延開始フラグ
        trigger_flag: False               #トリガー開始フラグ
    feature:                              #役割と機能
      - name: 'SNMP サービス'             #名前(フルパス)
    eventlog:                             #イベントログ
      application:                        #アプリケーション
        filepath: 'C:\Windows\system32\winevt\Logs\Application.evtx'      #ログのパス
        type: 'overwrite'                 #ローテーション設定
        maxsize: 2048                     #最大サイズ(KB)
      security:                           #セキュリティ
        filepath: 'C:\Windows\system32\winevt\Logs\Security.evtx'         #ログのパス
        type: 'archive'                   #ローテーション設定
        maxsize: 2048                     #最大サイズ(KB)
      system:                             #システム情報
        filepath: 'C:\Windows\system32\winevt\Logs\System.evtx'           #ログのパス
        type: 'none'                      #ローテーション設定
        maxsize: 2048                     #最大サイズ(KB)
    product:                              #プログラムと機能
      - name: 'VMware Tools'              #プログラム名
      - name: 'Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161'     #プログラム名
    hotfix:                               #更新プログラム(hotfix)
      - id: 'KB2842230'                   #KB番号(hotfix ID)
    registry:                             #レジストリ
      - key: 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion'     #キー
        value:                            #値
          - name: 'RegisteredOrganization'     #名前
            type: 'String'                #種類
            data: 'TIS'                   #データ
    error_report: 'disabled'              #Windowsエラー報告
    windows_update: 'disabled'            #Windows Update
    psexecpolicy: 'RemoteSigned'          #Powershell実行ポリシー(ComputerScope)
    snmp:                                 #SNMPサービス設定
      security:                           #セキュリティ
        authentication_trap: True         #認証トラップ送信
        allow_trap_from:                  #トラップ許可
          host:                           #ホスト
            - ip: 'localhost'             #IPアドレス/ホスト名
```

### Please put nvspbind.exe to target
本ロールを用いてIPv6無効化のテストを行う場合は、exeファイル`nvspbind.exe`が必要になります。本ファイルはWindowsマシンにて[https://gallery.technet.microsoft.com/Hyper-V-Network-VSP-Bind-cf937850](https://gallery.technet.microsoft.com/Hyper-V-Network-VSP-Bind-cf937850)からEXEファイル「Microsoft_Nvspbind_package.EXE」をダ>ウンロードし、実行することで取得できます。取得が完了したら`nvspbind.exe`をターゲットの任意の場所に配置してください。その後、配置した場所の絶対パスをパラメータ`NETWORK.ipv6.nvspbind_path`に記載して下さい。なお、2-9901_PreDevを利用すると、`nvspbind.exe`のターゲットへの配置を自動化することができます。

記載例:
```
192.168.127.100:
  NETWORK:
    ipv6:
      nvspbind_path: 'C:\.shift\nvspbind.exe'
```

### How to run（Shift_Bin)
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent roles
- none
