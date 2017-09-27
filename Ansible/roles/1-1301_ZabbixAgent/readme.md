# RoleName : 1-1301_ZabbixAgent

---------------

## Synopsis
Zabbix Agent の設定をします。本ロールは``Zabbix Agent 3.2``を前提として実装しております。

## Tested platforms
platform | ver | 
-------- |-----|
Red Hat Enterprise Linux|6.5
Red Hat Enterprise Linux|7.1

## Tasks
- ZabbixAgentのインストール
- zabbix_agentd.confの設定
- ZabbixAgentの起動・停止
- ZabbixAgentの自動起動設定

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
192.168.127.101:
  ZabbixAgent:
      package:                                             # インストールパッケージ
          - name: 'zabbix-agent-3.2.6-1.el6.x86_64.rpm'    # パッケージ名
      config:                                              # zabbix_agentd.confの設定 
          pidfile: '/var/run/zabbix/zabbix_agentd.pid'     # PIDファイルの名前(RHEL6のみ変更可能)
          logfile: '/var/log/zabbix/zabbix_agentd.log'     # ログファイルの名前
          enableremotecommands: '0'                        # Zabbixサーバからのリモートコマンドの許可
          server: '192.168.0.1'                            # ZabbixサーバのIPアドレス
          listenport: '10050'                              # リッスンポート
          serveractive: '192.168.0.1:10050'                # アクティブチェック用のZabbixサーバのIP:ポート
          hostnameitem: 'system.hostname'                  # ホストネームアイテム
          timeout: '3'                                     # タイムアウト
          allowroot: '0'                                   # エージェントのルート実行許可
          include:                                         # インクルード設定
              - path: '/etc/zabbix/zabbix_agentd.d/*.conf' # インクルードファイル
      service:                                             # サービス設定
          state: 'started'                                 # サービスの状態
          enabled: 'yes'                                   # 自動起動設定
```

### Please put package files
本ロールでZabbixAgentをインストールするために、ZabbixAgentインストールパッケージを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

* Shift_Env/files

### How to run  
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none
