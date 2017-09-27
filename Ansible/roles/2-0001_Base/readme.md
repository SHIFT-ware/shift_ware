# RoleName : 2-0001_Base

---------------

## Synopsis
WindowsのOS設定を行います。

## Tested platforms

platform | ver | 
-------- |-----|
WindowsServer|2012
WindowsServer|2012R2

## Tasks
- Powershellスクリプト実行許可設定  
- チーミング設定
- ネットワークインターフェース設定
- ルーティング設定
- 名前解決設定
- ファイアーウォール設定
- IPv6無効化設定
- ユーザ設定
- グループ設定
- ホスト名設定
- ドメイン設定
- DNSサフィックス設定
- 役割と機能の設定
- サービス設定
- ディレクトリ作成
- Windowsエラー報告設定
- イベントログ設定
- メモリ設定
- 組織、使用者設定
- リモートデスクトップ設定
- 起動と回復の設定
- レジストリ設定
- タイムゾーン設定
- UAC設定
- WindowsUpdate設定  

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
BASE:                                   #BASE 
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
        password: 'p@ssw0rd'            #パスワード
        groups: 'Administrators'        #所属グループ
        account_disabled: no            #アカウントを無効にする?
        user_cannot_change_password: no    #ユーザはパスワードを変更できない?
        password_never_expires: yes     #パスワードを無期限にする?
      - name: 'testuser'                #ユーザ名
        password: 'p@ssw0rd'            #パスワード
        groups: 'Users'                 #所属グループ
        account_disabled: no            #アカウントを無効にする?
        user_cannot_change_password: no   #ユーザはパスワードを変更できない?
        password_never_expires: no      #パスワードを無期限にする?
    group:                              #グループ
      - name: 'Administrators'          #名前
      - name: 'Users'                   #名前
    uac:                                #ユーザアカウント制御
      level: 'low'                      #レベル
  OSCORE:                               #OSコア設定
    timezone: 'Tokyo Standard Time'     #タイムゾーン
    recover_os:                         #起動と回復
      display_os_list_time: 30          #OS一覧表示時間(秒)
      write_eventlog: True              #イベントログ書込み
      auto_reboot: True                 #自動再起動
      dumpfile:                         #ダンプファイル
        type: 'auto'                    #種類
        path: 'C:\Windows\MEMORY.DMP'   #ファイルパス
        overwrite: True                 #上書き
STORAGE:                                #STORAGE
  directory:                            #ディレクトリ
    - path: 'C:\temp'                   #パス
      owner: 'BUILTIN\Administrators'   #所有者
      acl:                              #アクセス制御リスト(ACL)
        - user: 'BUILTIN\Users'         #対象ユーザ/グループ
          rights: 'Read, Synchronize'   #権限
          type: 'Allow'                 #許可/拒否
          inherit: 'thisfolder, subfolder, file'     #適用先(複数選択化)
        - user: 'testuser'              #対象ユーザ/グループ
          rights: 'FullControl'         #権限
          type: 'Allow'                 #許可/拒否
          inherit: 'thisfolder'         #適用先(複数選択化)
NETWORK:                                #NETWORK
  hostname: 'target40'                  #コンピュータ名
  domain:                               #所属するグループ
    type: 'workgroup'                   #ドメイン/ワークグループ
    name: 'WORKGROUP'                   #ドメイン名/ワークグループ名
    user: 'Administrator'               #ドメイン参加/脱退用ユーザ
    password: 'p@ssw0rd'                #ドメイン参加/脱退用パスワード
  eth:                                  #ネットワークインターフェース
    - name: 'イーサネット'              #インターフェース名
      dhcp: False                       #DHCP有効/無効
      ipaddress: '192.168.127.40'       #IPアドレス(IPv6非対応)
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
  default_gw: '192.168.127.254'         #デフォルトゲートウェイ(IPv6非対応)
  static_routing:                       #スタティックルート
    - dest: '192.168.0.0'               #宛先ネットワーク(IPv6非対応)
      mask: '255.255.255.0'             #サブネットマスク(IPv6非対応)
      gw: '192.168.127.254'             #ゲートウェイ(IPv6非対応)
    - dest: '192.168.1.0'               #宛先ネットワーク(IPv6非対応)
      mask: '255.255.255.0'             #サブネットマスク(IPv6非対応)
      gw: '192.168.127.254'             #ゲートウェイ(IPv6非対応)
  name_resolve:                         #名前解決
    hosts_records:                      #hostsレコード
      - ip: '192.168.127.10'            #IPアドレス(IPv6非対応)
        hostname: 'target10'            #ホスト名
      - ip: '192.168.127.20'            #IPアドレス(IPv6非対応)
        hostname: 'target20'            #ホスト名
    dns_server:                         #DNSサーバー
      nic_name: 'teamnic1'              #紐付けるインターフェース名
      server:                           #DNSサーバー
        - ip: '192.168.127.254'         #IPアドレス(IPv6非対応)
        - ip: '127.0.0.1'               #IPアドレス(IPv6非対応)
  firewall:                             #ファイアーウォール
    domain:                             #ドメインプロファイル
      enabled_flag: 'True'              #有効/無効
    private:                            #プライベートプロファイル
      enabled_flag: 'True'              #有効/無効
    public:                             #パブリックプロファイル
      enabled_flag: 'True'              #有効/無効
  ipv6:                                 #IPv6無効化設定
    nvspbind_path: 'C:\.shift\nvspbind.exe'            #nvspbind.exe のパス
    registry: 'disabled'                #レジストリからの無効化
    nic_property: 'disabled'            #NICのプロパティからの無効化
    netsh_command:                      #netshコマンドからの無効化
      isatap_if: 'disabled'             #isatapインターフェース
      sixtofour_if: 'disabled'          #6to4インターフェース
      teredo_if: 'disabled'             #teredoインターフェース
  dns_suffix:                           #DNSサフィックス
    primary:                            #プライマリDNSサフィックス
      fqdn: 'tistest.local'             #FQDN
      change_when_domain_membership_changed: True      #ドメインのメンバシップに連動
ADVANCED:                               #ADVANCED
  organization: 'TIS'                   #組織名
  owner: 'TIS'                          #使用者名
  rdp: 'enabled'                        #リモートデスクトップ接続
  service:                              #サービス
    - name: 'DHCP Client'               #サービス名
      state: True                       #実行状態
      start_mode: 'Auto'                #スタートアップの種類
  feature:                              #役割と機能
    - name: 'SNMP サービス'             #名前(フルパス)
  eventlog:                             #イベントログ
    application:                        #アプリケーション
      filepath: 'C:\Windows\system32\winevt\Logs\Application.evtx'     #ログのパス
      type: 'overwrite'                 #ローテーション設定
      maxsize: 2048                     #最大サイズ(KB)
    security:                           #セキュリティ
      filepath: 'C:\Windows\system32\winevt\Logs\Security.evtx'        #ログのパス
      type: 'archive'                   #ローテーション設定
      maxsize: 2048                     #最大サイズ(KB)
    system:                             #システム情報
      filepath: 'C:\Windows\system32\winevt\Logs\System.evtx'          #ログのパス
      type: 'none'                      #ローテーション設定
      maxsize: 2048                     #最大サイズ(KB)
  registry:                             #レジストリ
    - key: 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion'     #キー
      value:                            #値
        - name: 'RegisteredOrganization'              #名前
          type: 'String'                #種類
          data: 'TIS'                   #データ
  error_report: 'disabled'              #Windowsエラー報告
  windows_update: 'disabled'            #Windows Update
  psexecpolicy: 'RemoteSigned'          #Powershell実行ポリシー(ComputerScope)
```

### Please put nvspbind.exe to target
本ロールを用いてIPv6の設定を行う場合は、exeファイル`nvspbind.exe`が必要になります。本ファイルはWindowsマシンにて[https://gallery.technet.microsoft.com/Hyper-V-Network-VSP-Bind-cf937850](https://gallery.technet.microsoft.com/Hyper-V-Network-VSP-Bind-cf937850)からEXEファイル「Microsoft_Nvspbind_package.EXE」をダウンロードし、実行することで取得できます。取得が完了したら`nvspbind.exe`をターゲットの任意の場所に配置してください。その後、配置した場所の絶対パスをパラメータ`NETWORK.ipv6.nvspbind_path`に記載して下さい。なお、2-9901_PreDevを利用すると、`nvspbind.exe`のターゲットへの配置を自動化することができます。

記載例:
```
NETWORK:
  ipv6:
    nvspbind_path: 'C:\.shift\nvspbind.exe'
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none

## Caution
- IPv6には対応しておりません。
- Ansibleモジュールの不具合により、「ユーザ設定」にて無効なアカウントへの設定変更ができません。OSユーザの構成定義を利用する場合、事前に対象ユーザの「アカウントを無効にする」のチェックを外してください。
