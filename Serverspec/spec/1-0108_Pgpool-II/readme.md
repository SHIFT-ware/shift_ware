# RoleName : 1-0108_Pgpool-II

---------------

## Synopsis
pgpool-IIの設定が正しく行われているか、チェックします。本ロールはpgpool-IIのバージョン3.4.8、postgreSQLのバージョン9.4を前提として実装しています。

## Tested platforms

platform | ver |
-------- |---|
Redhat Enterprise Linux|6.5

## Tasks
本ロールでは以下の項目をテストします。
* パッケージ、サービス
    * pgpoolのパッケージがインストールされていること
    * pgpoolのサービスの起動状態が指定通りであること
    * pgpoolのサービスの自動起動設定が指定通りであること
* pgpool実行ユーザ所属グループ
    * プライマリグループ
        * グループが存在すること
        * gidが指定通りであること
    * セカンダリグループ
        * グループが存在すること
        * gidが指定通りであること
* pgpool実行ユーザ
    * pgpool実行ユーザが存在すること
    * pgpool実行ユーザのuidが指定通りであること
    * pgpool実行ユーザの所属プライマリグループが指定通りであること
    * pgpool実行ユーザの所属セカンダリグループがが指定通りであること
    * pgpool実行ユーザのホームディレクトリが指定通りであること
    * pgpool実行ユーザのログインシェルが指定通りであること
* 設定ファイル
    * /etc/pgpool-II/pgpool.conf
        * MD5値が指定通りであること
    * /etc/pgpool-II/pcp.conf
        * 指定したpcpユーザのエントリがあること
    * /etc/pgpool-II/pool_passwd
        * 指定したpostgresqlユーザのエントリがあること
    * /etc/pgpool-II/pool_hba.conf
        * 指定したエントリがあること

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

なお、pgpool.confのMD5値を計算するには以下のコマンドがご利用いただけます。

```sh
# md5sum <期待するpgpool.confファイル>
```

パラメータ例:
```yaml
192.168.127.101:                                           # ターゲットのIP
  operating_system: Linux                                  # ターゲットのOS
  Pgpool:
    state: started                                         # サービスの起動状態
    enabled: yes                                           # サービスの自動起動設定
    exec_groups:                                           # サービス実行ユーザの所属グループ
      primary:                                             # サービス実行ユーザの所属プライマリグループ
        name: root                                         # ユーザ名
        gid: 0                                             # gid
      seconcary:                                           # サービス実行ユーザの所属セカンダリグループ
        - name: test1                                      # ユーザ名
          gid: 1001                                        # gid
        - name: test2                                      # ユーザ名
          gid: 1002                                        # gid
    exec_user:                                             # サービス実行ユーザ 
      name: root                                           # ユーザ名
      uid: 0                                               # uid
      home_dir: /root                                      # ホームディレクトリ
      shell: /bin/bash                                     # ログインシェル
    config:                                                # pgpool.confの設定
      md5sum: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'           # pgpool.confのMD5値
    pcp_users:                                             # pcp.conf記載のユーザ
      - name: test                                         # pcpユーザ名
    pool_passwd:                                           # pool_passwd記載のpostgresユーザ
      - name: postgres                                     # postgersユーザ名
    pool_hba:                                              # pool_hba.conf記載のエントリ
      - type: local                                        # タイプ
        database: all                                      # アクセス許可するデータベース
        user: all                                          # アクセス許可するユーザ
        method: trust                                      # 認証方法
      - type: host                                         # タイプ
        database: postgres                                 # アクセス許可するデータベース
        user: postgres                                     # アクセス許可するユーザ
        address: 192.168.127.102/32                        # アクセス許可するネットワーク
        method: md5                                        # 認証方法
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent roles
- none
