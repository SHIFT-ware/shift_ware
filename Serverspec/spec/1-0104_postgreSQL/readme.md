# RoleName : 1-0104_postgreSQL

---------------

## Synopsis
postgreSQLの設定を確認します。本ロールはpostgreSQLのバージョン9.4.3を前提として実装しています。

## Tested platforms

| platform | ver | 
| -------- | ----- |
| Redhat Enterprise Linux | 6.5 |

## Tasks
- サービス起動ユーザpostgres
    - 存在すること
    - uidが指定通りであること
    - 所属プライマリグループがpostgresであること
    - 所属セカンダリグループが指定通りであること
    - ホームディレクトリが/var/lib/pgsqlであること
    - ログインシェルが指定通りであること
- サービス起動ユーザ所属プライマリグループpostgres
    - 存在すること
    - gidが指定通りであること
- サービス起動ユーザ所属セカンダリグループ
    - 存在すること
    - gidが指定通りであること

- PostgreSQLのインストール確認
    - postgresのパッケージインストール確認
    - postgresユーザの.bash_profileの確認
        - .bash_profileのPGDATA環境変数にPostgreSQLインストールディレクトリのパスをexportする記述がされていること
        - .bash_profileのPATH環境変数にPostgreSQLのbinディレクトリのパスをexportする記述がされていること
        - .bash_profileのLD_LIBRARY_PATH環境変数にPostgreSQLのライブラリディレクトリのパスをexportする記述がされていること
    - WALディレクトリの確認
        - 存在していること
    - サービスが起動していること
    - サービス自動起動設定が指定通りであること

- /var/lib/pgsql/(バージョン)/data/postgresql.confファイルのmd5チェックサムが一致すること
- /var/lib/pgsql/(バージョン)/data/pg_hba.confファイルの設定確認
    - 指定された接続設定レコードが記述されていること
- レプリケーションの設定確認
    - Masterサーバでの確認
        - リカバリモードになっていないことの確認
    - Slaveサーバでの確認
        - リカバリモードになっていることの確認
        - Masterサーバと同期できていることの確認
        - /var/lib/pgsql/(バージョン)/data/recovery.confの設定確認
            - パラメータ primary_conninfo の値が指定通りであること

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yml
  PostgreSQL:
    state: started                                      # サービス起動状態
    enabled: yes                                        # サービス自動起動設定
    exec_groups:                                        # サービス起動ユーザの所属グループ
      primary:                                          # プライマリグループ(postgres)
        gid: 1000                                       # gid
      secondary:                                        # セカンダリグループ
        - name: test1                                   # グループ名
          gid: 1001                                     # gid
        - name: test2                                   # グループ名
          gid: 1002                                     # gid
    exec_user:                                          # サービス起動ユーザ(postgres)
      uid: 1000                                         # uid
      shell: /bin/bash                                  # ログインシェル
    db_user:                                            # データベース管理者ユーザ
      name: 'postgres'                                  # ユーザ名
      password: 'postgres'                              # パスワード
    version: '9.4'                                      # バージョン
    wal_archive_dir: /var/lib/pgsql/wal_archive         # WALアーカイブディレクトリ
    postgresql_conf:                                    # 設定ファイルpostgresql.conf
      conf_file_md5: '1b65bead9e89523383a94a852a5716d0' # MD5値
    authentication:                                     # 接続認証設定(pg_hba.conf)
      records:                                          # 認証設定レコード
        - type: 'local'                                 # タイプ
          database: 'all'                               # 許可データベース
          user: 'all'                                   # 許可ユーザ
          method: 'trust'                               # 認証手法
        - type: 'host'                                  # タイプ
          database: 'all'                               # 許可データベース
          user: 'all'                                   # 許可ユーザ
          address: '192.168.127.0/24'                   # 許可アドレス(typeがlocalの場合、不要)
          method: 'md5'                                 # 認証手法
        - type: 'host'                                  # タイプ
          database: 'replication'                       # 許可データベース
          user: 'replication'                           # 許可ユーザ
          address: '192.168.127.0/24'                   # 許可アドレス(typeがlocalの場合、不要)
          method: 'md5'                                 # 認証手法
    cluster:                                            # ストリーミングレプリケーション設定
      replication_user:                                 # レプリケーション実行ユーザ
        name: 'replication'                             # ユーザ名
        password: 'replication'                         # パスワード
      server_role: 'slave'                              # サーバの役割(master or slave)
      master_address: '192.168.127.104'                 # マスターサーバのアドレス
      master_port: 5432                                 # マスターサーバの接続ポート
      slave_name: 'slave1'                              # application_name(server_roleがslaveのときにみ必須)
```

### How to run  
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none
