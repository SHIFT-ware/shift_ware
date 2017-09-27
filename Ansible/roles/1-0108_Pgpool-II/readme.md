# RoleName : 1-0108_Pgpool-II

---------------

## Synopsis
pgpool-Ⅱの設定を行います。 本ロールはpgpool-IIのバージョン3.4.8、postgreSQLのバージョン9.4を前提として実装しています。

## Tested platforms
platform | ver | 
-------- |-----|
Red Hat Enterprise Linux|6.5

## Tasks
- パッケージインストール
- サービス起動ユーザ所属グループ設定
- サービス起動ユーザ設定
- 全体設定ファイルpgpool.confの配置
- pcp設定ファイルpcp.confの編集
- ACL設定ファイルpool_hba.confの編集
- パスワードファイルpool_passwdの編集

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
remote_tmp_dir: "/root/.shift"                               # 一時ディレクトリのパス

Pgpool:
  packages:                                                  # pgpool-IIのパッケージおよび依存パッケージ
    - name: libmemcached-0.31-1.1.el6.x86_64.rpm
    - name: pgpool-II-pg94-3.4.8-1pgdg.rhel6.x86_64.rpm
    - name: postgresql94-9.4.10-1PGDG.rhel6.x86_64.rpm
    - name: postgresql94-libs-9.4.10-1PGDG.rhel6.x86_64.rpm
    - name: postgresql-libs-8.4.20-6.el6.x86_64.rpm
  state: started                                             # サービス起動状態
  enabled: yes                                               # サービス自動起動設定
  exec_groups:                                               # サービス起動ユーザ所属グループ
    primary:                                                 # サービス起動ユーザ所属プライマリグループ
      name: postgres                                         # グループ名
      gid: 1000                                              # gid
    secondary:                                               # サービス起動ユーザ所属セカンダリグループ
      - name: test1                                          # グループ名
        gid: 1001                                            # gid
      - name: test2                                          # グループ名
        gid: 1002                                            # gid
  exec_user:                                                 # サービス起動ユーザ
    name: postgres                                           # ユーザ名
    uid: 1000                                                # uid
    home_dir: /root                                          # ホームディレクトリ
    shell: /bin/bash                                         # ログインシェル
    password: p@ssw0rd                                       # パスワード
  config:                                                    # pgpool.conf
    filename: pgpool_192.168.127.100.conf                    # pgpool.confファイル名
  pcp_users:                                                 # pcp.confに記載するユーザ
    - name: postgres                                         # ユーザ名
      password: p@ssw0rd                                     # パスワード
    - name: pgpool                                           # ユーザ名
      password: p@ssw0rd                                     # パスワード
  pool_passwd:                                               # pool_passwdに記載するユーザ
    - name: postgres                                         # ユーザ名
      password: p@ssw0rd                                     # パスワード
    - name: pgpool                                           # ユーザ名
      password: p@ssw0rd                                     # パスワード
  pool_hba:                                                  # pool_hbaに記載するACLエントリ
    - type: local                                            # タイプ
      database: all                                          # アクセス許可するデータベース名
      user: all                                              # アクセス許可するユーザ名
      method: trust                                          # 認証方式
    - type: host                                             # タイプ
      database: all                                          # アクセス許可するデータベース名
      user: all                                              # アクセス許可するユーザ名
      address: 0.0.0.0/0                                     # アクセス許可するネットワークのアドレス
      method: md5                                            # 認証方式

```

### Please put package files
本ロールでpgpool-IIをインストールするために、pgpool-II本体のパッケージおよびその依存パッケージを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

- Shift_Env/files

### How to set config file
- 本ロールでは、pgpool-IIの全体設定ファイルであるpgpool.confをユーザにて作成いただく必要がございます。作成いただいたpgpool.confファイルは以下の場所に配置いただくことで対象サーバに自動的に配置されます。
    - Shift_Env/files/
- pgpool.confファイルはその内容がサーバ間で異なる場合、本ロール実行サーバ毎に異なるファイル名で作成、配置してください。
- host_vars内でpgpool.confのファイル名を本ロール実行サーバ毎に指定してください。

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none

## Caution 
- サービス起動ユーザおよびその所属グループが存在しなかった場合はhost_varsに記載のパラメータに基づいて新規作成されます。
- サービス起動ユーザおよびその所属グループが既に存在する場合はサービス起動ユーザおよびその所属グループに関する設定は一切行われません。これは既存の設定を変更することによって他のソフトウェアの動作を阻害してしまうことを避けるためです。
