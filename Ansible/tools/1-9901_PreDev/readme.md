# ToolName : 1-9901_PreDev

---------------

## Synopsis
- SHIFT wareを実行するにあたり、ターゲット側に必要となる設定をします。
- 1-9901_PreDev実行後は以下の状態になります。
  - SELinuxで制限されているAnsibleのモジュールが実行可能となります。
  - shiftユーザ(SHIFT ware実行用ユーザ)がターゲットホストに作成されます。このユーザはパスワード不要で使用でき、root権限でコマンドが実行できます。
- この設定をもとに戻すには1-9902_PostDevを利用頂けます。
  
## Tested platforms
platform | ver | 
-------- |---|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1
Cent OS|6.5
Cent OS|7.1

## Tasks
- Selinuxの無効化
- shiftユーザ(SHIFT ware実行用ユーザ)の作成
- shiftユーザのSSH鍵登録
- 一時ディレクトリの作成
- shiftユーザのSUDO権限付与
- SSH鍵認証の有効化

## Usage
### How to set inventory
本ツールはロール実行時のインベントリファイルとは別に専用のインベントリファイルが必要です。以下のファイル名で記載例に従って作成してください。なお、ファイル名が規則に従っていれば複数のファイルに分割して記載も可能です。この場合、ファイル内の各ターゲットに対してツールは並列実行され、全ターゲットに対し実行が終わると次のファイル内の各ターゲットに対しツール実行が行われます。

- Shift_Env/tools/1-9901_PreDev.{任意の文字列}.inventory 

記載例:
```
[targethost]
192.168.xxx.101 ansible_ssh_pass=password

[targethost:vars]
ansible_ssh_port=22

#全台共通の場合はここに記載
#ansible_ssh_user=root
#ansible_ssh_pass=password
```

### How to run
本ツール実行のためには以下のコマンドを実行してください。

  ```
  # Shift_Bin/tools/1-9901_PreDev.sh run
  ```

## Dependencies
- none

## Caution
- 本ツールの実行により、ターゲットが再起動される場合があります。
- 本ツールにおいては、接続ユーザのパスワードである`ansible_ssh_password`がsudo実行時のパスワードとしても利用されます。このため、接続ユーザのパスワードとsudo実行時のパスワードが異なる場合は、`var.yml`内の`ansible_become_pass`にsudo実行時のパスワードを直接指定してください。

記載例
```
---
ansible_ssh_user: root
ansible_become_pass: password

  ～省略～
```

- 本ツールにおいては、特別な理由がない限り実行ユーザとしてrootをご利用ください。実行ユーザを変更したい場合、Ansible/tools/1-9901_Predev/var.yml内のパラメータ`ansible_ssh_user`を変更ください。
- 本ツールを実行すると、自動的に秘密鍵`<ツール実行ユーザのホームディレクトリ>/.ssh/id_rsa_shift`が作成されます。本鍵は本ツールを実行したターゲットに対し、SHIFT ware専用ユーザ`shift`で接続するために必要なカギですので、取り扱いにご注意ください。
