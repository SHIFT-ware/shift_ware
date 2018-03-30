# RoleName : 2-1301_ZabbixAgent

---------------

## Synopsis
zabbix-agentの設定が正しく行われているか、チェックします。本ロールは``Zabbix Agent 3.2``を前提として実装しております。

### Tested platforms
platform | ver |
-------- |---|
Windows Server|2012R2
Windows Server|2016

### Tasks
本ロールでは以下を確認するテストが実装されております。
- ZabbixAgentの実行ファイルが存在すること
- ZabbixAgentの関連ファイルが存在すること
- ZabbixAgentサービス
    - サービスが存在すること  
    - 起動状態が指定通りであること
    - 自動起動の有無が指定通りであること
- 指定したポート番号でリッスンしていること
- zabbix_agentd.conf
    - LogFileの値が指定通りであること
    - EnableRemoteCommandsの値が指定通りであること
    - Serverの値が指定通りであること
    - ListenPortの値が指定通りであること
    - ServerActiveの値が指定通りであること
    - HostnameItemの値が指定通りであること
    - Timeoutの値が指定通りであること
    - Includeの値が指定通りであること
- Zabbixサーバにホスト情報が登録されていること

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yaml
192.168.127.101:
    ZabbixAgent:
        install_path: 'C:\Program Files (x86)\ZabbixAgent'  # インストールディレクトリ
        installer: 'zabbix_agentd.exe'                      # インストーラ
        files:                                              # その他ファイル
            - name: 'zabbix_get.exe'                        # ファイル名
            - name: 'zabbix_sender.exe'                     # ファイル名
        config:                                             # zabbix_agentd.confの設定 
            logfile: 'C:\Program Files (x86)\ZabbixAgent\zabbix_agentd.log'  # ログファイルの名前
            enableremotecommands: '0'                           # Zabbixサーバからのリモートコマンドの許可
            server: '192.168.0.1'                               # ZabbixサーバのIPアドレス
            listenport: '10050'                                 # リッスンポート
            serveractive: '192.168.0.1:10050'                   # アクティブチェック用のZabbixサーバのIP:ポート
            hostnameitem: 'system.hostname'                     # ホストネームアイテム
            timeout: '3'                                        # タイムアウト
        service:                                            # サービス設定
            state: 'started'                                # サービスの状態
            start_mode: 'auto'                              # 自動起動設定
        zabbix_host:                                        # Zabbixサーバへ登録したホスト情報。ホスト情報チェックが不要な場合は定義しない。
            server_url: 'http://192.168.0.1/zabbix'         # Zabbixサーバが提供するAPI(管理画面)のURL
            login_user: 'Admin'                             # Zabbixサーバのログインユーザ
            login_pass: 'zabbix'                            # Zabbixサーバのログインパスワード
            host_name: 'host1'                              # 登録したホスト名
            visible_name: 'HOST NAME 1'                     # 登録したホストの表示名
            host_groups:                                    # 登録したホストに割り当てた所属グループ
                - name: 'Linux servers'
            link_templates:                                 # 登録したホストに割り当てたテンプレート名
                - name: 'Template OS Linux'
            status: < enabled | disabled >                  # 登録したホストの監視ステータス
            inventory_mode: < automatic | manual | disabled> # 登録したホストのインベントリモード
            interfaces:                                     # 登録したホストのインタフェース情報
                - type: 1
                  main: 1
                  useip: 1
                  ip: 192.168.127.101
                  dns: ""
                  port: 10050
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Caution
- Zabbixサーバへのホスト情報チェックにはあらかじめコントロールマシンにPythonのzabbix-apiパッケージをインストールしておく必要があります。
　zabbix-apiパッケージはShiftContribパッケージと一緒にインストールされます。ShiftContribパッケージの導入方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をごらんください。

### Dependent roles
- none
