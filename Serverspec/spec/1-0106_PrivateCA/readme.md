# RoleName : 1-0106_PrivateCA

---------------

## Synopsis
自己署名認証局のエージェントのインストール、初期設定を確認します。

## Tested platforms

platform | ver | 
-------- |-----|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1

## Tasks
- InstallCA-agent
  - インストールパスの確認
  - 証明書の存在確認(pem)
  - 証明書の存在確認(der)
- ValidityCert
  - 証明書の有効期限確認  
- CheckConfig
  - CSRポリシーの確認
  - 拡張領域のコピー確認
- DistinguishedName
  - 以下証明書情報の確認
    - 国名
    - 都道府県
    - 市区町村
    - 組織名
    - 部門名
    - コモンネーム
    - メールアドレス
- PrivateKey
  - 秘密鍵の存在確認
  - 秘密鍵の鍵長確認
  - 秘密鍵のパスフレーズ確認
- HashAlgorithm
  - 利用するハッシュ関数の確認

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yml
#---------------
  PrivateCA:
#---------------
    install_path: '/etc/pki/CA'                          # CAのインストールパス
    ca_cert:                                             # CA証明書の情報
      pem_filename: 'cacert.pem'                         # CA証明書(pem形式)のファイル名
      der_filename: 'cacert.crt'                         # CA証明書(der形式)のファイル名
      csr_validity_term: 1095                            # CA証明書の有効期限
      distinguished_name:                                # ディスティングイッシュネーム
        country: 'JP'                                    # 国名
        state: 'Tokyo'                                   # 都道府県
        locality_name: 'Shinjuku'                        # 地区町村
        organization: 'TIS inc.'                         # 組織名
        unit_name: 'IT Infrastructure Technology SBU.'   # 部門名
        common_name: 'sample@example.com'                # コモンネーム
        email: 'sample@tis.co.jp'                        # Emailアドレス(省略可)
      private_key_filename: 'cakey.pem'                  # 秘密鍵のファイル名
      private_key_length: 2048                           # 秘密鍵の鍵長
      private_key_passphrase: 'passphrase'               # 秘密鍵のパスフレーズ
      hash_algorithm: 'sha256'                           # 秘密鍵を暗号化する際に用いられるハッシュ関数
```
### How to run  
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none
