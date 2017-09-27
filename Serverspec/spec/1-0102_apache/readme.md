# RoleName : 1-0102_apache

---------------

## Synopsis
Apache HTTP Serverの設定が正しく行われているか、チェックします。本ロールはApache HTTP Serverのバージョン2.4を前提として実装しています。

## Tested platforms

platform | ver |
-------- |---|
Redhat Enterprise Linux|6.5

## Tasks
本ロールでは以下の項目をテストします。
* サービス起動ユーザ所属グループ
    * プライマリグループ
        * 存在すること
        * gidが指定通りであること
    * セカンダリグループ
        * 存在すること
        * gidが指定通りであること
* サービス起動ユーザ
    * 存在すること
    * uidが指定通りであること
    * 所属プライマリグループが指定通りであること
    * 所属セカンダリグループが指定通りであること
    * ホームディレクトリが指定通りであること
    * ログインシェルが指定通りであること
* パッケージhttpd
    * インストールされていること
* サービスhttpd
    * 起動状態が指定通りであること
    * 自動起動設定が指定通りであること
* 設定ファイル/etc/httpd/conf/httpd.conf
    * MPM workerモジュールをロードする設定になっていること(apache.mpm.typeにworkerを指定した場合のみ)
    * MPM preforkモジュールをロードする設定になっていること(apache.mpm.typeにpreforkを指定した場合のみ)
    * Listenの値が指定通りであること
    * ServerNameの値が指定通りであること
    * DocumentRootの値が指定通りであること
    * ServerAdminの値が指定通りであること
    * ErrorLogの値が指定通りであること
    * CustomLogの値が指定通りであること
    * /etc/httpd/conf/extra/httpd-vhosts.confをインクルードする設定になっていること
    * /etc/httpd/conf/extra/httpd-ssl.confをインクルードする設定になっていること
    * mod_sslモジュールをロードする設定になっていること
* 設定ファイル/etc/httpd/conf/extra/httpd-autoindex.conf
    * /var/www/iconsディレクトリに対し、FollowSymLinksの有効/無効が指定通りであること
* 設定ファイル/etc/httpd/conf/extra/httpd-mpm.conf
    * ThreadLimitの値が指定通りであること
    * StartServersの値が指定通りであること
    * MaxClientsの値が指定通りであること
    * ThreadsPerChildの値が指定通りであること
    * MaxRequestsPerChildの値が指定通りであること
    * MinSpareThreadsの値が指定通りであること
    * MaxSpareThreadsの値が指定通りであること
    * ServerLimitの値が指定通りであること
    * MaxRequestsPerChildの値が指定通りであること
* 設定ファイル/etc/httpd/conf/extra/httpd-default.conf
    * Timeoutの値が指定通りであること
    * KeepAliveの値が指定通りであること
    * MaxKeepAliveRequestsの値が指定通りであること
    * KeepAliveTimeoutの値が指定通りであること
    * ServerTokensの値が指定通りであること
* 設定ファイル/etc/httpd/conf/extra/httpd-info.conf
    * <Location /server-status>にRequire all grantedが指定されていること(apache.visible_server_statusがtrue, apache.accessible_addresses.0.addressが0.0.0.0のときのみ)
    * <Location /server-status>にRequire ipが指定されていること(apache.visible_server_statusがtrue, apache.accessible_addresses.0.addressが0.0.0.0以外のときのみ)
    * <Location /server-status>にRequire ip 127が指定されていること(apache.visible_server_statusがfalseのときのみ)
    * <Location /server-info>にRequire all grantedが指定されていること(apache.visible_server_infoがtrue, apache.accessible_addresses.0.addressが0.0.0.0のときのみ)
    * <Location /server-info>にRequire ipが指定されていること(apache.visible_server_infoがtrue, apache.accessible_addresses.0.addressが0.0.0.0以外のときのみ)
    * <Location /server-info>にRequire ip 127が指定されていること(apache.visible_server_infoがfalseのときのみ)
* 設定ファイル/etc/httpd/conf/extra/httpd-languages.conf
    * AddDefaultCharsetにUTF-8の指定が指示通りであること
    * LanguagePriorityにおいてjaの優先度が指定通りであること
* 設定ファイル/etc/httpd/conf/extra/httpd-userdir.conf
    * UserDirにdisabledの指定が指示通りであること
* バイナリファイル/etc/httpd/modules/mod_jk.so
    * 存在すること
* 設定ファイル/etc/httpd/conf.d/mod_jk.conf
    * <Location /jkstatus/>にAllow fromが指定されていること
* 設定ファイル/etc/httpd/conf.d/workers.properties
    * worker.template.portが指定通りであること
    * worker.template.socket_timeoutが指定通りであること
    * worker.template.socket_keepaliveが指定通りであること
    * worker.template.connection_pool_sizeが指定通りであること
    * worker.template.connection_pool_minsizeが指定通りであること
    * worker.listにstatusを指定していること
    * worker.status.typeにstatusを指定していること
    * worker.listに指定したAPサーバのjvmrouteが指定されていること
    * worker.[APサーバのjvmroute].referenceにworker.templateが指定されていること
    * worker.[APサーバのjvmroute].hostが指定通りであること
    * worker.[APサーバのjvmroute].lbfactorが指定通りであること
    * worker.loadbalancer.balance_workersに指定したAPサーバのjvmrouteが指定されていること
    * worker.listにloadbalancerを指定していること
    * worker.loadbalancer.typeにlbを指定していること
    * worker.loadbalancer.sticky_sessionが指定通りであること
* 設定ファイル/etc/httpd/conf.d/uriworkermap.properties
    * 指定したURIに対しワーカが指定通りであること
* 設定ファイル/etc/httpd/conf/extra/httpd-vhosts.conf
    * VirtualHost
        * ServerNameが指定通りであること
        * DocumentRootが指定通りであること
        * ServerAdminが指定通りであること
        * ServerAliasが指定通りであること
        * ErrorLogの値が指定通りであること
        * CustomLogの値が指定通りであること
        * SSLCertificateFileが指定通りであること
        * SSLCertificateKeyFileが指定通りであること
        * 利用ポートが指定通りであること
        * SSLCertificateFileに指定した証明書が存在すること
        * SSLCertificateKeyFileに指定した秘密鍵が存在すること

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yaml
192.168.127.100:                                                     # ターゲットのIP
  operating_system: Linux                                            # ターゲットのOS
  apache:
    state: started                                                   # サービスの起動状態
    enabled: true                                                    # サービスの自動起動設定
    exec_user:                                                       # サービス実行ユーザ
      name: apache                                                   # ユーザ名
      uid: 48                                                        # uid
      home_dir: /var/www                                             # ホームディレクトリ
      shell: /sbin/nologin                                           # ログインシェル
    exec_groups:                                                     # サービス実行ユーザの所属グループ
      primary:                                                       # プライマリグループ
        name: apache                                                 # グループ名
        gid: 48                                                      # gid
      secondary:                                                     # セカンダリグループ
        - name: test1                                                # グループ名
          gid: 1001                                                  # gid
        - name: test2                                                # グループ名
          gid: 1002                                                  # gid
    mod_jk:                                                          # mod_jk設定
      common_params:                                                 # 共通
        ajp_port: 8009                                               # AJPポート番号
        socket_timeout: 60                                           # socket_timeout
        socket_keepalive: "False"                                    # socket_keepalive
        connection_pool_size: 200                                    # connection_pool_size
        connection_pool_minsize: 0                                   # connection_pool_minsize
        connection_pool_timeout: 60                                  # connection_pool_timeout
      loadbalance:                                                   # ロードバランサ設定
        sticky_session: yes                                          # sticky_sessionの有効無効
      linked_ap_servers:                                             # 連携するAPサーバ
        - jvmroute: tomcat01                                         # jvmroute
          host: 192.168.127.101                                      # ホスト名orIP
          weight: 1                                                  # ロードバランス時の重み(小さいほうが優先)
        - jvmroute: tomcat02                                         # jvmroute
          host: 192.168.127.102                                      # ホスト名orIP
          weight: 1                                                  # ロードバランス時の重み(小さいほうが優先)
      jkmount:                                                       # URIマップの設定
        - uri: /jkstatus                                             # uri
          workers: status                                            # 対応させるワーカ(カンマ区切りで記載)
          positive: yes                                              # 対応の有効無効
    Listen:                                                          # Listen
      - port: 80                                                     # ポート番号
      - port: 443                                                    # ポート番号
    ServerName: www.example.com:80                                   # ServerName
    DocumentRoot: /var/www/html                                      # DocumentRoot
    ServerAdmin: you@example.com                                     # ServerAdmin
    ErrorLog: /var/log/httpd/error_log                               # ErrorLog
    CustomLog: /var/log/httpd/access_log combined env=!no_log        # CustomLog
    Timeout: 60                                                      # Timeout
    KeepAlive: "Off"                                                 # KeepAlive
    MaxKeepAliveRequests: 100                                        # MaxKeepAliveRequests
    KeepAliveTimeout: 15                                             # KeepAliveTimeout
    ServerTokens: OS                                                 # ServerTokens
    autoindex:                                                       # httpd-autoindex設定
      enable_followsymlinks: yes                                     # /var/www/iconsに対するFollowSymLinksオプションの有効無効
    visible_server_status: yes                                       # server_statusの可視不可視
    visible_server_info: yes                                         # server_infoの可視不可視
    is_default_charset_utf8: yes                                     # デフォルト言語をUTF8にするか
    is_1st_prior_language_ja: yes                                    # 言語優先度でjaを1番にするか
    disable_userdir: no                                              # ディレクティブUserDirをdisabledとするか
    accessible_addresses:                                            # アクセス可能なIP
      - address: 0.0.0.0
    virtualhost:                                                     # VirtualHost設定
      vhosts:                                                        # VirtualHost
        - ServerName: dummy-host.example.com                         # ServerName
          DocumentRoot: \"/usr/docs/dummy-host.example.com\"         # DocumentRoot
          ServerAdmin: webmaster@dummy-host.example.com              # ServerAdmin
          ServerAlias: www.dummy-host.example.com                    # ServerAlias
          CustomLog: /var/log/httpd/access_nossl.log combined        # CustomLog
          ErrorLog: /var/log/httpd/error_nossl.log                   # ErrorLog
          port: 80                                                   # 利用ポート
      ssl_vhosts:                                                    # VirtualHost(SSL対応)
        - ServerName: dummy-host2.example.com                        # ServerName
          DocumentRoot: \"/usr/docs/dummy-host2.example.com\"        # DocumentRoot
          ServerAdmin: webmaster@dummy-host2.example.com             # ServerAdmin
          ServerAlias: test                                          # ServerAlias
          CustomLog: /var/log/httpd/access_ssl.log combined          # CustomLog
          ErrorLog: /var/log/httpd/error_ssl.log                     # ErrorLog
          SSLCertificateFile: /etc/pki/tls/server.crt                # SSLCertificateFile
          SSLCertificateKeyFile: /etc/pki/tls/private/server.key     # SSLCertificateKeyFile
          port: 443                                                  # 利用ポート
    mpm:                                                             # MPM設定
      type: worker                                                   # MPMのタイプ(workerかprefork)
      worker:                                                        # MPM worker設定
        ThreadLimit: 100                                             # ThreadLimit
        StartServers: 4                                              # StartServers
        MinSpareThreads: 25                                          # MinSpareThreads
        MaxSpareThreads: 75                                          # MaxSpareThreads
        MaxClients: 300                                              # MaxClients
        ThreadsPerChild: 25                                          # ThreadsPerChild
        MaxRequestsPerChild: 0                                       # MaxRequestsPerChild
      prefork:                                                       # MPM prefork設定
        StartServers: 8                                              # StartServers
        MinSpareServers: 5                                           # MinSpareServers
        MaxSpareServers: 20                                          # MaxSpareServers
        ServerLimit: 256                                             # ServerLimit
        MaxClients: 256                                              # MaxClients
        MaxRequestsPerChild: 4000                                    # MaxRequestsPerChild
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent roles
- none
