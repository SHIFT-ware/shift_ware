# RoleName : 1-0104_postgreSQL

---------------

## Synopsis
postgreSQL のインストール、初期設定を構築します。本ロールはpostgreSQLのバージョン9.4.3を前提として実装しています。シングル構成、ストリーミングレプリケーション構成での構築に対応しています。

## Tested platforms
| platform | ver |
| -------- | ----- |
| Red Hat Enterprise Linux | 6.5 |

## Tasks
- サービス起動ユーザの所属プライマリグループ作成
- サービス起動ユーザの所属セカンダリグループ作成
- サービス起動ユーザの作成
- 共通設定
    - パッケージインストール
    - DBディレクトリ作成
    - postgresユーザのbash_profileを編集
        - 環境変数 PGDATA を定義
        - 環境変数 PATH にインストールディレクトリを追加
        - 環境変数 LD_LIBRARY_PATH にPostgreSQLのライブラリパスを追加
    - DBディレクトリ初期化
    - サービス起動
    - DB管理者ユーザのパスワード設定
    - WALディレクトリ作成
- /var/lib/pgsql/(バージョン)/data/postgresql.confファイルに指定されたファイルを転送
- /var/lib/pgsql/(バージョン)/data/pg_hba.confファイルの設定
- レプリケーションの設定（ストリーミングレプリケーション構成のパラメータで実行した場合のみ）
    - MasterサーバでDBにレプリケーションユーザを作成
    - Slaveサーバでpg_basebackupコマンドを実行
    - Slaveサーバで(インストールディレクトリ)/data/recovery.confを作成
- サービス設定
    - サービス起動設定
    - サービス自動起動設定

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yml
PostgreSQL:
  packages:                                                      # インストールパッケージ
    - name: 'postgresql94-server-9.4.10-1PGDG.rhel6.x86_64.rpm' 
    - name: 'postgresql94-9.4.10-1PGDG.rhel6.x86_64.rpm'
    - name: 'postgresql94-libs-9.4.10-1PGDG.rhel6.x86_64.rpm'
    - name: 'postgresql94-contrib-9.4.10-1PGDG.rhel6.x86_64.rpm'
    - name: 'postgresql94-devel-9.4.10-1PGDG.rhel6.x86_64.rpm'
    - name: 'postgresql94-docs-9.4.10-1PGDG.rhel6.x86_64.rpm'
    - name: 'libxslt-1.1.26-2.el6_3.1.x86_64.rpm'
  state: started                                                 # サービス起動状態
  enabled: yes                                                   # サービス自動起動設定
  exec_groups:                                                   # サービス起動ユーザ所属グループ
    primary:                                                     # プライマリグループ(postgres)
      gid: 1000                                                  # gid
    secondary:                                                   # セカンダリグループ
      - name: 'test1'                                            # グループ名
        gid: 1001                                                # gid
      - name: 'test2'                                            # グループ名
        gid: 1002                                                # gid
  exec_user:                                                     # サービス起動ユーザ(postgres)
    uid: 1000                                                    # uid
    shell: '/bin/bash'                                           # ログインシェル
    password: 'password'                                         # パスワード
  db_user:                                                       # DB管理者ユーザ
    name: 'postgres'                                             # ユーザ名
    password: 'postgres'                                         # パスワード
  version: '9.4'                                                 # バージョン
  wal_archive_dir: /var/lib/pgsql/wal_archive                    # WALアーカイブディレクトリ
  initdb_option:                                                 # initdbコマンドオプション
    encoding: 'UTF-8'                                            # エンコード
    locale: 'C'                                                  # ロケール
  postgresql_conf:                                               # 設定ファイルpostgresql.conf
    conf_file: 'postgresql_slave.conf'                           # 設定ファイル名
  authentication:                                                # 接続認証設定(pg_hba.conf)
    records:                                                     # 認証設定レコード
      - type: 'local'                                            # タイプ
        database: 'all'                                          # 許可データベース
        user: 'all'                                              # 許可ユーザ
        method: 'trust'                                          # 認証手法
      - type: 'host'                                             # タイプ
        database: 'all'                                          # 許可データベース
        user: 'all'                                              # 許可ユーザ
        address: '192.168.127.0/24'                              # 許可アドレス(typeがlocalの場合、不要)
        method: 'md5'                                            # 認証手法
      - type: 'host'                                             # タイプ
        database: 'replication'                                  # 許可データベース
        user: 'replication'                                      # 許可ユーザ
        address: '192.168.127.0/24'                              # 許可アドレス(typeがlocalの場合、不要)
        method: 'md5'                                            # 認証手法
  cluster:                                                       # ストリーミングレプリケーション設定
    replication_user:                                            # レプリケーション実行ユーザ
      name: 'replication'                                        # ユーザ名
      password: 'replication'                                    # パスワード
    server_role: 'slave'                                         # サーバの役割(master or slave)
    master_address: '192.168.127.104'                            # マスターサーバのアドレス
    master_port: 5432                                            # マスターサーバの接続ポート
    slave_name: 'slave1'                                         # application_name(server_roleがslaveのときにみ必須)
```

### Please put package files
本ロールでpostgreSQLをインストールするために、postgreSQL本体とその依存パッケージを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

* Shift_Env/files

### How to set config file
- 本ロールでは、postgreSQLの全体設定ファイルであるpostgresql.confをユーザにて作成いただく必要がございます。作成いただいたpostgresql.confファイルは以下の場所に配置いただくことで対象サーバに自動的に配置されます。
    - Shift_Env/files/
- postgresql.confファイルはその内容がサーバ間で異なる場合、本ロール実行サーバ毎に異なるファイル名で作成、配置してください。
- host_vars内でpostgresql.confのファイル名を本ロール実行サーバ毎に指定してください。

### How to run  
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none

## Caution
- iptablesの設定は行いません。ストリーミングレプリケーション構成の構築をする場合、Masterサーバのiptablesは事前にサービスを停止しておくか適切な設定を行った状態にして下さい。
