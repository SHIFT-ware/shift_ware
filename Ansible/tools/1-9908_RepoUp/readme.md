# ToolName : 1-9908_RepoUp

---------------

## Synopsis
- ターゲットにYumリポジトリを作成し、リポジトリサーバを起動します。
- インターネットに繋がらないクローズドな環境において、本ツールで作成したYumリポジトリサーバを利用し、RPMパッケージのインストールが行えます。
- 本ツールで作成したYumリポジトリは1-9909_RepoDestroyを利用することで削除できます。
  
## Tested platforms
platform | ver | 
-------- |---|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1
Cent OS|6.7
Cent OS|7.2

## Caution
- 本ツールで起動されるYumリポジトリサーバはHTTPプロトコルを利用します。このため、事前にTCP80番ポートにアクセスできるようシステムを構成してください。
- 本ツールを実行した後、作成したYumレポジトリサーバを参照するためのrepoファイルは1-9910_RepofilePutで作成、配置することができます。

## Usage
### How to set inventory
本ツールはロール実行時のインベントリファイルとは別に専用のインベントリファイルが必要です。以下のファイル名で記載例に従って作成してください。なお、ファイル名が規則に従っていれば複数のファイルに分割して記載も可能です。この場合、ファイル内の各ターゲットに対してツールは並列実行され、全ターゲットに対し実行が終わると次のファイル内の各ターゲットに対しツール実行が行われます。

- Shift_Env/tools/1-9908_RepoUp.{任意の文字列}.inventory 

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

### Where should we put createrepo package
Yumリポジトリを作成するためのcreaterepoおよびその依存パッケージは`Shift_Env/files/shift/yum_repo/`に配置してください。

### Where should we put packages for yum repository
作成するYumリポジトリに含むパッケージは`Shift_Env/files/shift/yum_repo/packages`に配置してください。

### How to run
本ツール実行のためには以下のコマンドを実行してください。

  ```
  # Shift_Bin/tools/1-9908_RepoUp.sh run
  ```

## Tasks
- 一時ディレクトリの作成
- createrepoパッケージのインストール
- リポジトリ用ディレクトリの作成
- リポジトリの作成
- リポジトリサーバの起動

## Dependencies
- none

## More infomation 
- 本ツールで作成されるYumリポジトリサーバはOSを再起動すると停止してしまいます。リポジトリサーバプロセスが停止した際には本ツールを再度実行することで起動することができます。

