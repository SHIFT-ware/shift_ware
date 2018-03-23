# RoleName : 1-0102_apache

---------------

## Synopsis
Apache HTTP Server の設定を行います。本ロールはApache HTTP Serverのバージョン2.4を前提として実装しています。

## Tested platforms
platform | ver |
-------- |-----|
Red Hat Enterprise Linux|6.5

## Tasks
- サービス起動ユーザの所属グループの設定
- サービス起動ユーザの設定
- Apache HTTP Serverのインストール
- /etc/httpd/conf/httpd.confの設定
- /etc/httpd/conf/extra/httpd-autoindex.confの設定
- /etc/httpd/conf/extra/httpd-mpm.confの設定
- /etc/httpd/conf/extra/httpd-default.confの設定
- /etc/httpd/conf/extra/httpd-info.confの設定
- /etc/httpd/conf/extra/httpd24-languages.confの設定
- /etc/httpd/conf/extra/httpd-userdir.confの設定
- mod_jkバイナリの配置
- /etc/httpd/conf.d/mod_jk.confの配置
- /etc/httpd/conf.d/workers.propertiesの配置
- /etc/httpd/conf.d/uriworkermap.propertiesの配置
- ドキュメントルートの作成
- /etc/httpd/conf/extra/httpd-vhosts.confの設定
- /etc/httpd/conf/extra/httpd-ssl.confの設定
- サーバ証明書の配置
- サーバ秘密鍵の配置
- サービスの起動設定
- サービスの自動起動設定

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
remote_tmp_dir: "/root/.shift"

apache:
  state: started                                                   # サービスの起動状態
  enabled: true                                                    # サービスの自動起動設定
  exec_user:                                                       # サービス実行ユーザ
    name: apache                                                   # ユーザ名
    uid: 48                                                        # uid
    home_dir: /var/www                                             # ホームディレクトリ
    shell: /sbin/nologin                                           # ログインシェル
    password: p@ssw0rd                                             # パスワード
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
  Listen:                                                          # Listen(複数指定可能)
    - port: 80
    - port: 443
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
  accessible_addresses:                                            # /server-status,/server-info,/jkstatusにアクセス可能なIP
    - address: 0.0.0.0
  virtualhost:                                                     # VirtualHost設定
    vhosts:                                                        # VirtualHost
      - ServerName: dummy-host.example.com                         # ServerName
        DocumentRoot: /usr/docs/dummy-host.example.com             # DocumentRoot
        ServerAdmin: webmaster@dummy-host.example.com              # ServerAdmin
        ServerAlias: www.dummy-host.example.com                    # ServerAlias
        CustomLog: /var/log/httpd/access_nossl.log combined        # CustomLog
        ErrorLog: /var/log/httpd/error_nossl.log                   # ErrorLog
        port: 80                                                   # 利用するポート
    ssl_vhosts:                                                    # VirtualHost(SSL対応)
      - ServerName: dummy-host2.example.com                        # ServerName
        DocumentRoot: /usr/docs/dummy-host2.example.com            # DocumentRoot
        ServerAdmin: webmaster@dummy-host2.example.com             # ServerAdmin
        ServerAlias: test                                          # ServerAlias
        CustomLog: /var/log/httpd/access_ssl.log combined          # CustomLog
        ErrorLog: /var/log/httpd/error_ssl.log                     # ErrorLog
        SSLCertificateFile: /etc/pki/tls/ca.crt                    # SSLCertificateFile
        SSLCertificateKeyFile: /etc/pki/tls/private/ca.key         # SSLCertificateKeyFile
        port: 443                                                  # 利用するポート
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

### Please put package files
本ロールでapacheをインストールするために、apache本体とモジュールのパッケージおよびその依存パッケージを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

* Shift_Env/files

### Please put mod_jk.so
本ロールでmod_jkを用いたAPサーバとの連携を行いたい場合、Shared Objectファイルmod_jk.soをユーザにて作成し、以下のディレクトリに配置してください。またファイル名は「mod_jk.so」のままとしてください。mod_jk.soの作成についてはThe Apache Tomcat Connectorsの公式HPをご覧ください。

* Shift_Env/files

### Please put certificates and keys
本ロールを用いてSSLサイトを設定したい場合、apache.virtualhost.ssl_vhostsの各要素に記載のSSLCertificateFileおよびSSLCertificateKeyFileに記載した証明書、秘密鍵を以下のディレクトリに配置してください。またファイル名は各パラメータに記載のままとしてください。(例: /etc/pki/tls/ca.crtと記載したのであれば、ca.crtとする)

* Shift_Env/files

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none

## Caution
- MPM設定(server_mpm)は、「worker」or「prefork」からの選択となります。 「event」を選択したい場合は、手動での変更をお願いいたします。
- サービス起動ユーザおよびその所属グループが存在しなかった場合はhost_varsに記載のパラメータに基づいて新規作成されます。
- サービス起動ユーザおよびその所属グループが既に存在する場合はサービス起動ユーザおよびその所属グループに関する設定は一切行われません。これは既存の設定を変更することによって他のソフトウェアの動作を阻害してしまうことを避けるためです。

