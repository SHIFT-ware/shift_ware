# RoleName : 1-0001_Base

---------------

## Synopsis
Linux OSのOS設定が正しく行われているかテストします。

## Tested platforms

platform | ver | 
-------- |---|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1

## Tasks
本ロールでは以下のテストが実装されております。

- ハードウェアのテスト
    - CPUのテスト
        - CPUのコア数の確認
        - ハイパースレッディングの設定確認(未検証)
    - メモリのテスト
        - メモリ量の確認
- ユーザ/グループのテスト
    - ユーザのテスト
        - ユーザの存在確認
        - uidの確認
        - プライマリグループの確認
        - ホームディレクトリの確認
        - ログインシェルの確認
        - セカンダリグループの確認
    - グループのテスト
        - グループの存在確認
        - gidの確認
    - パスワードポリシーのテスト
        - パスワード期限の確認
        - パスワード変更不可期間の確認
        - パスワードの最小文字数の確認
        - パスワード期限切れ警告開始日の確認
- OSコア機能のテスト
    - OSバージョンのテスト
    - OSロケールのテスト
    - キーボード設定のテスト
        - キーボード設定の確認
    - 時刻設定のテスト
        - タイムゾーンの確認
        - ハードウェアクロックのUTC設定確認
    - ランレベルのテスト
    - SELinux設定のテスト
    - Kdump設定のテスト
        - サービスの起動/停止確認
        - dumpの出力先確認
    - GRUB設定のテスト
- ストレージのテスト
    - パーティションのテスト
        - デバイスファイル名の確認
        - ファイルシステムの確認
        - パーティションサイズの確認
    - ディレクトリのテスト
        - ディレクトリの存在確認
        - 所有者確認
        - 所有グループ確認
        - パーミッション確認
- ネットワークのテスト
    - ホスト名のテスト
    - NICのテスト
        - NICがUP状態であることの確認
        - IPアドレスの確認
        - ボンディングインタフェースのテスト
            - メンバーインタフェース名の確認
    - ルーティングのテスト
        - デフォルトゲートウェイの確認
        - スタティックルートの確認
- OSアドバンスド機能のテスト
    - 名前解決のテスト
        - hosts登録内容のテスト
        - DNSサーバ登録内容のテスト
        - hosts/DNS優先順位のテスト
    - Syslogのテスト
        - フィルタの設定内容のテスト
    - cronのテスト
        - cron登録内容のテスト
    - ログローテーションのテスト
        - ローテートサイクルの確認
        - ローテート世代数の確認
        - ローテート時に新規ログファイルを作成するかの確認
        - ログファイルにタイムスタンプをつけるかの確認
        - ログファイルを圧縮するかの確認
        - 対象ログファイルの存在確認
    - パッケージのテスト
        - パッケージがインストールされていることの確認
    - サービスのテスト
        - サービスの起動/停止確認
        - サービスの自動起動設定確認
    - NTPのテスト
        - NTPサーバの指定先確認
        - 時刻同期確認
        - slewモード設定確認
    - sshdのテスト
        - rootログイン許可設定の確認
        - パスワード認証許可設定の確認
    - SNMPのテスト
        - コミュニティ名の登録内容の確認
        - トラップ送信設定の確認

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
192.168.127.101:                                   # ターゲットのIP
  operating_system: Linux                          # ターゲットのOS
#---------------
  BASE:
#---------------
    HW:                                         
      cpu_core_sum: 1                              # CPUコア数(コア数*ソケット数で計算)
      cpu_hyper_thread: off                        # ハイパースレッディングの有効/無効(on/off)
      mem_size: 2097152                            # メモリサイズ(KB指定)
    ID: 
      user:                                        # ユーザ設定
        - name: test1                              # ユーザ名(複数指定可)
          uid: 1000                                # uid
          group: test1                             # プライマリグループ
          home_dir: /home/test1                    # ホームディレクトリ
          shell: /bin/bash                         # ログインシェル
          sub_groups: testgrp1,testgrp2            # セカンダリグループ(カンマ区切りにて記載)
      user_group:                                  # グループ設定
        - name: testgrp1                           # グループ名(複数指定可)
          gid: 1002                                # gid
      password_policy:                             # パスワードポリシー
        max_days: 99999                            # あるパスワードの最大期限（日数）99999:無期限をあらわす
        min_days: 0                                # パスワードを変えたあと、変更不可の期間（日数）0:制限無効化
        min_length: 5                              # 最少文字数。0:制限なし
        warn_age: 7                                # パスワード期限切れの警告を何日前から行うか。0：当日,負数：警告なし
    OSCORE:
      version: 7.1                                 # OSバージョン
      lang: ja_JP.UTF-8                            # OSロケール
      keyboard:                                    # キーボード設定
        keybord_locale: jp106                      # キーテーブル・キーレイアウト
      time:                                        # 時刻設定
        timezone: Asia/Tokyo                       # タイムゾーン
        utc: off                                   # ハードウェアクロックのUTC設定
      runlevel: 3                                  # ランレベル
      selinux: enforcing                           # SELinux設定(enforcing/permissive/disabled)
      kdump:                                       # Kdump設定
        service_state: running                     # サービスが起動しているか否か(running/stop)
        path: /var/crash                           # dumpの出力先
      grub_option:                                 # GRUB設定
        - key: timeout                             # キー(複数指定可)
          value: 5                                 # キーの値
#---------------
  STORAGE:
#---------------
    mount_point:                                   # マウントポイント
      - path: /                                    # マウントポイントのパス(複数指定可)
        device_file_name: /dev/mapper/rhel-root    # デバイスファイル名
        file_system: xfs                           # ファイルシステム
        size: 6818                                 # サイズ
    directory:                                     # ディレクトリ
      - path: /                                    # ディレクトリのパス(複数指定可)
        owner_user: root                           # 所有者
        owner_group: root                          # グループ
        permission: 555                            # パーミッション(4桁指定は不可)
        
#---------------
  NETWORK:
#---------------
    hostname: test71                               # ホスト名
    interface:                                     # NIC設定
      - name: ens192                               # NIC名(複数指定可)
        ip_addr: 192.168.127.101/24                # IPアドレス(x.x.x.x/yの形式で記載)
    bonding_interface:                             # ボンディングインタフェース
      - name: bond0                                # ボンディングインタフェース名(複数指定可)
        member_interface:                          # メンバーインタフェース設定
          - name: ens193                           # メンバーインタフェース名(複数指定可) 
          - name: ens194                           # メンバーインタフェース名(複数指定可) 
    default_gw:                                    # デフォルトゲートウェイ設定
      addr: 192.168.127.254                        # デフォルトゲートウェイ
      if: ens192                                   # 利用するNIC名
    static_routing:                                # スタティックルート設定
      - dest: 172.16.0.0/24                        # 宛先ネットワーク(x.x.x.x/yの形式で記載。複数指定可)                      
        if: bond0                                  # 利用するNIC名
        gw: 192.168.0.254                          # ゲートウェイアドレス
#---------------
  ADVANCED:
#---------------
    name_resolve:                                  # 名前解決設定
      hosts_records:                               # hostsのレコード
        - server: test71                           # サーバ名(複数指定可)
          ip: 192.168.127.101                      # 対応するIPアドレス
      name_server:                                 # DNSサーバ設定
        - server: 192.168.127.254                  # DNSサーバのIPアドレス(複数指定可)
      dns_suffix: example.com                      # DNSサフィックス
      pri_name_resolve: files                      # 名前解決をhostsから先に行うか、DNSから先に行うか(files/dns)
    syslog:                                        # Syslog設定
      filters:                                     # フィルタ設定
        - selector: local7.*                       # セレクタ(複数指定可)
          output: /var/log/boot.log                # ログの出力先
    cron:                                          # cron設定
      entry:                                       # cronのエントリ
        - record: '* * * * * /home/test1/test1.sh' # レコード(複数指定可)
          usr: test1                               # 実行ユーザ(未指定の場合は、Serverspec実行ユーザとなる)
    logrotate_basic_option:                        # ログローテーション設定
      cycle: weekly                                # ローテーションサイクル(daily/weekly/monthly)
      rotate_num: 4                                # ローテーション世代数
      create: on                                   # ログのローテーション後、新しいログファイルを作るか(on/off, offのテストは未実装)
      add_date: on                                 # ローテートされたログファイル名に日付を付与するか(on/off, offのテストは未実装)
      compress: on                                 # ローテーションされたログファイルを圧縮するか(on/off, offのテストは未実装)
    logrotate_files:                               # ログローテーション対象設定
        - path: /var/log/wtmp                      # 対象ファイルのパス(複数指定可)
    packages:                                      # パッケージ設定
      - name: openssl                              # パッケージ名(複数指定可)
        version: 1.0.1e-42.el7.x86_64              # バージョン(未指定時はパッケージの存在のみ確認)
    service:                                       # サービス設定
      - name: network                              # サービス名(複数指定可)
        state: on                                  # 起動状態(on/off)
        enable: on                                 # 自動起動設定(on/off)
    timeserver:                                    # NTPサーバ設定
      - server: 192.168.127.254                    # 参照するNTPサーバのIPアドレス
        prefer: on                                 # このサーバで優先的に同期するか(on/off, offのテストは未実装)
    ntp_option:                                    # NTPサービスオプション
      slew: on                                     # slewモード(on/off, offのテストは未実装)
    sshd:                                          # sshd設定
      permit_root_login: on                        # rootユーザでのログインを許可するか(on/off, offのテストは未実装)
      password_auth: on                            # パスワード認証を許可するか(on/off, offのテストは未実装)
    snmpd:                                         # SNMP設定
      sec:                                         # com2sec設定
        - sec_name: notConfigUser                  # セキュリティ名(複数指定可)
          source: default                          # ネットワーク範囲(defaultは任意ネットワーク)
          community: public                        # コミュニティ名
      trap:                                        # trap設定
        - server: 192.168.127.254                  # トラップの送信先
          port: 162                                # 利用するポート
          community: test                          # コミュニティ名
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent roles
- none

## Caution
ハイパースレッディングの設定確認のテストは実装されておりますが、未検証です。
