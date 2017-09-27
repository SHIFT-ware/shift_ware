# ToolName : 1-9902_PostDev

---------------

## Synopsis
1-9901_PreDevの実行を前提とし、この実行時の設定変更を元に戻します。

## Tested platforms
platform | ver | 
-------- |---|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1
Cent OS|6.5
Cent OS|7.1

## Tasks
- 一時ディレクトリの削除
- SSH鍵認証の無効化
- SELinuxの有効化
- SHIFT ware実行用ユーザの削除
  - ユーザ削除（鍵ファイル・ホームディレクトリごと削除）
- SSH鍵ファイル削除（Ansible実行サーバ）

## Usage 
### How to set inventory
本ツールはロール実行時のインベントリファイルとは別に専用のインベントリファイルが必要です。以下のファイル名で記載例に従って作成してください。なお、ファイル名が規則に従っていれば複数のファイルに分割して記載も可能です。この場合、ファイル内の各ターゲットに対してツールは並列実行され、全ターゲットに対し実行が終わると次のファイル内の各ターゲットに対しツール実行が行われます。

- Shift_Env/tools/1-9902_PostDev.{任意の文字列}.inventory

```
[targethost]
192.168.xxx.101 ansible_ssh_user=root ansible_ssh_pass=password

[targethost:vars]
ansible_ssh_port=22

#全台共通の場合はここに記載
#ansible_ssh_user=root
#ansible_ssh_pass=password
```

### How to run
本ツール実行のためには以下のコマンドを実行してください。

  ```
  # Shift_Bin/tools/1-9902_PostDev.sh run
  ```

## Dependencies
- none

### Caution
- 本ツールの実行により、ターゲットが再起動される場合があります。
- 本ツールにおいては、接続ユーザのパスワードである`ansible_ssh_password`がsudo実行時のパスワードとしても利用されます。このため、接続ユーザのパスワードとsudo
実行時のパスワードが異なる場合は、`var.yml`内の`ansible_become_pass`にsudo実行時のパスワードを直接指定してください。

記載例
```
---
ansible_ssh_user: root
ansible_become_pass: password

  ～省略～
```

- 本ツールの実行すると、自動的に秘密鍵`<ツール実行ユーザのホームディレクトリ>/.ssh/id_rsa_shift`が削除されます。本ツールを実行する際は十分にご注意ください。
- 本ツールの実行においては、shiftユーザをご利用になれません。これは本ツール実行の中でshiftユーザの削除を実施しているためです。本ツールの実行にはshiftユーザ以外のユーザをご利用ください。
- 本ツールにおいては、特別な理由がない限り実行ユーザとしてrootをご利用ください。実行ユーザを変更したい場合、Ansible/tools/1-9901_Predev/var.yml内のパラメータ`ansible_ssh_user`を変更ください。
