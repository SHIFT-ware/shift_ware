# ToolName : 1-9909_RepoDestroy

---------------

## Synopsis
- 1-9908_RepoUpにてターゲットに作成したYumリポジトリサーバを停止し、Yumリポジトリを削除します。
  
## Tested platforms
platform | ver | 
-------- |---|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1
Cent OS|6.7
Cent OS|7.2

## Usage
### How to set inventory
本ツールはロール実行時のインベントリファイルとは別に専用のインベントリファイルが必要です。以下のファイル名で記載例に従って作成してください。なお、ファイル名が規則に従っていれば複数のファイルに分割して記載も可能です。この場合、ファイル内の各ターゲットに対してツールは並列実行され、全ターゲットに対し実行が終わると次のファイル内の各ターゲットに対しツール実行が行われます。

- Shift_Env/tools/1-9909_RepoDestroy.{任意の文字列}.inventory 

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

### How to run
本ツール実行のためには以下のコマンドを実行してください。

  ```
  # Shift_Bin/tools/1-9909_RepoDestroy.sh run
  ```

## Tasks
- リポジトリサーバの停止
- リポジトリ用ディレクトリの削除
- (指定があれば)createrepoパッケージのアンインストール
- 1-9908_RepoUpが作成した一時ディレクトリの削除

## Dependencies
- none

## More infomation 
- 1-9908_RepoUpにてインストールされたcreaterepoパッケージをアンインストールしたいときは、`Ansible/tools/1-9909_RepoDestroy/var.yml`を開き、パラメータ`l9909_remove_createrepo`の値を`yes`にしてください。

```
l9909_remote_tmp_dir: "{{ l9908_remote_tmp_dir }}"
l9909_repository_dir: "{{ l9908_repository_dir }}"
l9909_remove_createrepo: yes
```
