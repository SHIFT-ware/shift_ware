# ToolName : 1-9910_RepofilePut

---------------

## Synopsis
- 1-9908_RepoUpが作成したYumリポジトリを参照するためのrepoファイルをターゲットに配置します。
  
## Tested platforms
platform | ver | 
-------- |---|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1
Cent OS|6.7
Cent OS|7.2

## Caution
- 本ツールは既存のrepoファイルを一時ディレクトリに退避させることで無効化します。無効化されたrepoファイルを再度有効化するには1-9911_RepofileRemoveをご利用ください。
- このツールを実行する前に、1-9908_RepoUpを用いてインターネットから遮断されたクローズド環境内にYumレポジトリサーバを立てることができます。

## Usage
### How to set inventory
本ツールはロール実行時のインベントリファイルとは別に専用のインベントリファイルが必要です。以下のファイル名で記載例に従って作成してください。なお、ファイル名が規則に従っていれば複数のファイルに分割して記載も可能です。この場合、ファイル内の各ターゲットに対してツールは並列実行され、全ターゲットに対し実行が終わると次のファイル内の各ターゲットに対しツール実行が行われます。

- Shift_Env/tools/1-9910_RepofilePut.{任意の文字列}.inventory 

記載例:
```
[targethost]
192.168.127.100 ansible_ssh_user=root ansible_ssh_pass=password

[targethost:vars]
ansible_ssh_port=22
#全台共通の場合はここに記載
#ansible_ssh_user=root
#ansible_ssh_pass=password
```

### Where should we set ip of yum repository
本ツールは1-9908_RepoUpで作成したYumリポジトリサーバのIPアドレスをパラメータにセットする必要があります。そのためには`Ansible/tools/1-9910_RepofilePut/var.yml`を開き、パラメータ`l9910_repo_server_ip`にIPアドレスをセットしてください。

```
l9910_repo_server_ip: "192.168.127.101"
```

### How to run
本ツール実行のためには以下のコマンドを実行してください。

  ```
  # Shift_Bin/tools/1-9910_RepofilePut.sh run
  ```

## Tasks
- 既存repoファイルの退避
- repoファイルの配置

## Dependencies
- none

