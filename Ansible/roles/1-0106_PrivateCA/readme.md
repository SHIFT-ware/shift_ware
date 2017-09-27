# RoleName : 1-0106_PrivateCA

---------------

## Synopsis
ターゲットサーバ上に自己署名認証局を構築します。

## Tested platforms

platform | ver | 
-------- |-----|
Red Hat Enterprise Linux|6.5
Red Hat Enterprise Linux|7.1

## Tasks
- インストールディレクトリの作成
- ディスティングイッシュネーム、証明書の有効期限、秘密鍵のパスフレーズの設定
- CAの構築および、CA証明書、CA秘密鍵の作成

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
---
PrivateCA
  install_path:             #CAのインストールパス
    '/etc/pki/CA'
  ca_cert:                  #CA証明書の情報
    pem_filename:           #CA証明書(PEM形式)のファイル名
        'cacert.pem'
    der_filename:           #CA証明書(DER形式)のファイル名
        'cacert.cer'
    csr_filename:           #CSRのファイル名
        'careq.pem'
    csr_validity_term:      #CA証明書の有効期限
        7300
    distinguished_name:     #ディスティングイッシュネーム
      country:              #国名
        'JP'
      state:                #都道府県
        'TOKYO'
      locality_name:        #市区町村
        'SHINJUKU-KU'
      organization:         #組織名
        'TIS inc.'
      unit_name:            #部門名
        'IT1'
      common_name:          #コモンネーム
        'sample.tis.co.jp'
      email:                #Emailアドレス(省略可。省略する場合は行ごと削除)
        'sample@tis.co.jp'
      challenge_pass:       #チャレンジパスワード(省略可。省略する場合は行ごと削除)
        'password'
      optional_company:     #組織名略称(省略可。省略する場合は行ごと削除)
        'TIS'
    private_key_filename:   #秘密鍵のファイル名
        'cakey.pem'
    private_key_length:     #秘密鍵の鍵長
        2048
    private_key_passphrase: #秘密鍵のパスフレーズ
        'password'
    hash_algorithm:         #秘密鍵を暗号化する際に用いられるハッシュ関数
      'sha256'
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependencies
- none
