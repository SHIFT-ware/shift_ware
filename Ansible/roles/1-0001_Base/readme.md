# RoleName : 1-0001_Base

---------------

## Synopsis
LinuxのOS設定を行います。

## Tested platforms

platform | ver | 
-------- |-----|
Red Hat Enterprise Linux|6.5
Red Hat Enterprise Linux|7.1

## Tasks
- GRUB設定
- ネットワークインターフェース設定
- ホスト名設定
- グループ設定
- ユーザ設定
- hosts設定
- 名前解決設定
- NTP設定
- SELinux設定
- cron設定
- 言語設定
- パスワードポリシー設定
- ログローテーション設定
- nsswitch設定
- ルーティング設定
- SSH設定
- kdump設定
- キーボード設定
- タイムゾーン設定
- ディレクトリ設定
- runlevel設定
- SNMP設定
- サービス設定
- syslog設定

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
BASE:                                    #BASE
  HW:                                    #HW
    cpu_core_sum: 1                      #CPUコア数
    cpu_hyper_thread: False              #ハイパースレッディング
    mem_size: 2097152                    #メモリサイズ
  ID:                                    #IP
    user:                                #ユーザ設定
      - name: 'test1'                    #ユーザ名
        password: 'password'             #パスワード
        uid: 1000                        #UID
        group: 'test1'                   #所属グループ
        home_dir: '/home/test1'          #ホームディレクトリ
        shell: '/bin/bash'               #ログインシェル
        sub_groups: 'test2'              #セカンダリグループ
      - name: 'test2'                    #ユーザ名
        password: 'password'             #パスワード
        uid: 1001                        #UID
        group: 'test2'                   #所属グループ
        home_dir: '/home/test2'          #ホームディレクトリ
        shell: '/bin/bash'               #ログインシェル
        sub_groups: 'test1'              #セカンダリグループ
    user_group:                          #グループ設定
      - name: 'test1'                    #グループ名
        gid: 1002                        #GID
      - name: 'test2'                    #グループ名
        gid: 1003                        #GID
    password_policy:                     #パスワードポリシー
      max_days: 99999                    #max_days
      min_days: 0                        #min_days
      min_length: 5                      #最小文字数
      warn_age: 7                        #warn_age
  OSCORE:                                #OSコア設定
    version: '7.1'                       #OSバージョン
    lang: 'ja_JP.UTF-8'                  #言語
    keyboard:                            #キーボード設定
      keybord_locale: 'jp106'            #キーテーブル・キーレイアウト
    time:                                #時刻設定
      timezone: 'Asia/Tokyo'             #タイムゾーン
      utc: False                         #UTC有効/無効
    runlevel: 3                          #runlevel
    selinux: 'enforcing'                 #SELinux
    kdump:                               #kdump
      service_state: 'running'           #サービス状態
      path: '/var/crash'                 #kdump出力先
    grub_option:                         #GRUBオプション
      - key: 'GRUB_DEFAULT'              #RHEL6 /etc/grub またはRHEL7 /etc/default/grub のエントリー
        value: 'saved'                   #値
      - key: 'GRUB_TIMEOUT'              #RHEL6 /etc/grub またはRHEL7 /etc/default/grub のエントリー
        value: '7'                       #値
STORAGE:                                 #STORAGE
  mount_point:                           #マウントポイント
    - path: '/'                          #パス
      device_file_name: '/dev/mapper/rhel-root'      #デバイスファイル
      file_system: 'xfs'                 #ファイルシステム
      size: 6818                         #サイズ
    - path: '/boot'                      #パス
      device_file_name: '/dev/sda1'      #デバイスファイル
      file_system: 'xfs'                 #ファイルシステム
      size: 497                          #サイズ
  directory:                             #サイズディレクトリ
    - path: '/'                          #パス
      owner_user: 'root'                 #所有ユーザ
      owner_group: 'root'                #所有グループ
      permission: 555                    #パーミッション
    - path: '/root'                      #パス
      owner_user: 'root'                 #所有ユーザ
      owner_group: 'root'                #所有グループ
      permission: 550                    #パーミッション
NETWORK:                                 #ETWORK
  hostname: 'target20'                   #ホスト名
  interface:                             #インターフェース設定
    - name: 'ens192'                     #インターフェース名
      ip_addr: '192.168.127.20/24'       #ip address / netmask(IPv6非対応)
    - name: 'ens161'                     #インターフェース名
      ip_addr: '192.168.1.20/24'         #ip address / netmask(IPv6非対応)
  bonding_interface:                     #bonding設定
    - name: 'bond0'                      #bondインターフェース名
      member_interface:                  #メンバー
        - name: 'ens225'                 #インターフェース名
        - name: 'ens193'                 #インターフェース名
    - name: 'bond1'                      #bondingインターフェース名
      member_interface:                  #メンバー
        - name: 'ens224'                 #インターフェース名
        - name: 'ens256'                 #インターフェース名
  default_gw:                            #デフォルトゲートウェイ
    addr: '192.168.127.254'              #IPアドレス(IPv6非対応)
    if: 'ens161'                         #インターフェース
  static_routing:                        #スタティックルート
    - dest: '172.16.1.0/24'              #宛先ip address / net mask(IPv6非対応)
      if: 'ens193'                       #インターフェース
      gw: '192.168.127.254'              #ゲートウェイ(IPv6非対応)
    - dest: '10.10.10.0/24'              #宛先ip address / net mask(IPv6非対応)
      if: 'ens193'                       #インターフェース
      gw: '192.168.127.254'              #ゲートウェイ(IPv6非対応)
ADVANCED:                                #ADVANCED
  name_resolve:                          #名前解決設定
    hosts_records:                       #hosts
      - server: 'target10'               #ホスト名
        ip: '192.168.127.10'             #IPアドレス(IPv6非対応)
      - server: 'target20'               #ホスト名
        ip: '192.168.127.20'             #IPアドレス(IPv6非対応)
    name_server:                         #DNSサーバ設定
      - server: '192.168.0.1'            #DNSサーバー(IPv6非対応)
      - server: '192.168.0.2'            #DNSサーバー(IPv6非対応)
    dns_suffix: 'tistest.local'          #dns_suffix
    pri_name_resolve: 'files'            #pri_name_resolve
  syslog:                                #syslog設定
    filters:                             #filters
      - selector: 'local7.*'             #facility / priority
        output: '/var/log/boot.log'      #ログ出力先
      - selector: '*.info;mail.none;authpriv.none;cron.none'     #facility / priority
        output: '/var/log/messages'      #ログ出力先
  cron:                                  #cron設定
    entry:                               #entry
      - record: '* * * * * /root/root.sh'                        #record
      - record: '* * * * * /home/test1/test1.sh'                 #record
        usr: 'test1'                     #ユーザ
  logrotate_basic_option:                #ログローテーション設定
    cycle: 'weekly'                      #ローテーション周期
    rotate_num: 4                        #ログファイルの世代数
    create: True                         #ローテーション後にログファイルを生成
    add_date: True                       #ログファイルに日付を付ける
    compress: True                       #ログファイルを圧縮する
  logrotate_files:                       #logrotate_files
    - path: '/var/log/wtmp'              #path
    - path: '/var/log/btmp'              #path
  packages:                              #パッケージ
    - name: 'openssh'                    #パッケージ名
    - name: 'openssl'                    #パッケージ名
      version: '1.0.1e-42.el7.x86_64'    #バージョン
  service:                               #サービス
    - name: 'network'                    #サービス名
      state: True                        #ステータス
      enable: True                       #自動起動
    - name: 'snmpd'                      #サービス名
      state: False                       #ステータス
  timeserver:                            #タイムサーバ設定
    - server: '192.168.127.21'           #タイムサーバ(IPv6非対応)
      prefer: True                       #prefer
    - server: '192.168.127.2'            #タイムサーバー(IPv6非対応)
      prefer: False                      #prefer
  ntp_option:                            #NTPオプション
    slew: True                           #slewモード
  sshd:                                  #ssh設定
    permit_root_login: True              #rootユーザのログインを許可
    password_auth: True                  #パスワード認証を許可
  snmpd:                                 #SNMP設定
    sec:                                 #セキュリティ
      - sec_name: 'notConfigUser'        #sec_name
        source: 'default'                #source
        community: 'public'              #community
      - sec_name: 'local'                #sec_name
        source: 'localhost'              #source
        community: 'COMMUNITY'           #community
    trap:                                #SNMPTrap設定
      - server: '192.168.0.10'           #Trap送信先(IPv6非対応)
        community: 'test1'               #community
        port: '162'                      #port
      - server: '192.168.0.11'           #Trap送信先(IPv6非対応)
        community: 'test2'               #community
        port: '162'                      #port

```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。  

## Dependent Roles
- none

## Caution
- 本ロール実行によってターゲットマシンの再起動が発生する場合があります。
- 本ロール実行によって各種サービスの再起動が発生する場合があります。
- 本ロールでユーザのパスワードを設定する場合、その過程で以下ファイルに平文のパスワードが記載されます。管理に十分ご注意ください。
  - Excel2YAML
  - Shift_Env/host_vars内のサーバ設定ファイル
  - Shift_Log内のlogファイル
- ユーザ設定においてターゲットマシン接続用のユーザを指定しないでください。設定変更によってAnsibleが予期せぬ動作をする恐れがあります。
- IPv6には対応しておりません。また以下のファイルにIPv6を無効にするコードが含まれています。
  - 1-0001-04_Hosts(IPv6)
    - /etc/hostsからIPv6のループバックアドレスを無効化
- RHEL7のターゲットに対する以下の設定はNetworkManagerを使用しています。NetworkManagerが停止、またはインストールされていないターゲットでは以下の設定はできません。
  - ネットワークインターフェース設定(bonding設定含む)
  - 名前解決設定
  - ルーティング設定
- キーボード設定を行う場合以下の設定は変更されません。
  - RHEL6: LAYOUT、MODEL
