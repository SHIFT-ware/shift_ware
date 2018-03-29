# RoleName : 2-1301_ZabbixAgent

---------------

## Synopsis
Zabbix Agent を導入します。また、Agentを導入したマシンの情報をホストとしてZabbix Serverに登録します。
本ロールは``Zabbix Agent 3.2``を前提として実装しています。

### Tested platforms
platform | ver | 
-------- |-----|
WindowsServer|2012R2
WindowsServer|2016

### Tasks
- Windowsファイアーウォールの設定
  - Zabbixエージェントの通信ポート(デフォルト TCP 10050)の開放
- zabbix_agentd.confの作成
- Zabbixエージェントのインストール
- Zabbixエージェントの起動・停止
- Zabbixエージェントの自動起動設定
- Zabbixサーバへホスト情報を登録

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yaml
192.168.127.101:
    ZabbixAgent:
        install_path: 'C:\Program Files (x86)\ZabbixAgent'  # インストール先ディレクトリ
        installer: 'zabbix_agentd.exe'                      # インストーラのファイル名
        firewall_profiles: 'public'                         # Windowsファイアーウォールで通信ポートの開放ルールを適用するプロファイル(カンマ区切りで複数指定可)
        files:                                              # インストーラと一緒に転送するファイル
            - name: 'zabbix_get.exe'                        
            - name: 'zabbix_sender.exe'                     
        config:                                             # zabbix_agentd.confの設定 
            logfile: 'C:\Program Files (x86)\ZabbixAgent\zabbix_agentd.log'   # ログファイルの名前
            enableremotecommands: '0'                       # Zabbixサーバからのリモートコマンドの許可
            server: '192.168.0.1'                           # ZabbixサーバのIPアドレス
            listenport: '10050'                             # リッスンポート（デフォルトTCP 10050）
            serveractive: '192.168.0.1:10050'               # アクティブチェック用のZabbixサーバのIP:ポート
            hostnameitem: 'system.hostname'                 # ホストネームアイテム
            timeout: '3'                                    # タイムアウト
        service:                                            # サービス設定
            state: 'started'                                # サービスの状態
            start_mode: 'auto'                              # 自動起動設定
        zabbix_host:                                        # Zabbixサーバへ登録するホスト情報。ホスト情報の登録が不要な場合は定義しない。
            server_url: 'http://192.168.0.1/zabbix'         # Zabbixサーバが提供するAPI(管理画面)のURL
            login_user: 'Admin'                             # Zabbixサーバのログインユーザ
            login_pass: 'zabbix'                            # Zabbixサーバのログインパスワード
            host_name: 'host1'                              # 登録するホスト名
            visible_name: 'HOST NAME 1'                     # 登録するホストの表示名
            host_groups:                                    # 登録するホストに割り当てる所属グループ
                - 'Windows servers'
            link_templates:                                 # 登録するホストに割り当てるテンプレート名
                - 'Template OS Windows'
            status: < enabled | disabled >                  # 登録するホストの監視ステータス
            state:  < present | absent >                    # present: ホストを作成もしくは更新、absent: 存在するホストを削除
            inventory_mode: < automatic | manual | disabled> # 登録するホストのインベントリモード
            interfaces:                                     # 登録するホストのインタフェース情報
                - type: 1                                   # インタフェースのタイプ（1: agent, 2: SNMP, 3: IPMI, 4: JMX）
                  main: 1                                   # 標準のインタフェースか否か（0: 標準でない, 1: 標準）
                  useip: 1                                  # アクセスする際にDNSを使用するか、IPアドレスを使用するか（0: DNS, 1: IPアドレス）
                  ip: 192.168.127.22                        # アクセスする際に使用するIPアドレス
                  dns: ""                                   # アクセスする際に使用するDNS名
                  port: 10050                               # アクセスする際に使用するポート番号(デフォルト10050)
```

### Please put package files
本ロールでZabbixAgentをインストールするために、ZabbixAgentインストーラ、その他必要なファイルを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

* Shift_Env/files

### How to run  
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

### Dependent Roles
- none

## Caution
- Zabbixサーバにホスト情報を登録するにはあらかじめコントロールマシンにPythonのzabbix-apiパッケージをインストールしておく必要があります。 zabbix-apiパッケージはShiftContribパッケージと一緒にインストールされます。ShiftContribパッケージの導入方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をごらんください。
- Zabbixサーバにホスト情報を登録する際はあらかじめホストに割り当てる所属グループ、テンプレートをZabbixサーバに登録しておいてください。
