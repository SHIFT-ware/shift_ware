# Release 2.0.0
## 新機能および改良点

### Windows Server 2016 対応

- Ansible 2.4.1 , Serverspec 2.41.3 でテスト済み

### Ansible 2.4 対応

- Ansible 2.4.3において動作するコードに変更

### 監視系Roleの追加

- Zabbix Agent Role
  - Windows , Linux 
- Hinemos Agent Role
  - Windows , Linux 

### YUM Repository Tool 対応

- 簡易的なYumリポジトリを作成するツール1-9908_RepoUpを追加
- 1-9908_RepoUpで作成したYumリポジトリを削除するツール1-9909_RepoDestroyを追加
- 1-9908_RepoUpで作成したYumリポジトリへの接続設定を行うツール1-9910RepofilePutを追加
- 1-9910_RepofilePutで行ったYumリポジトリへの接続設定を解除するツール1-9911RepofileRemoveを追加
- パッケージのインストールタスクをyumモジュールのみを利用するシンプルなものに変更

## バグフィックスやその他変更点

- カスタムフィルタ has_nested_keys の追加
- sshdに関するServerspecによるテスト内容の変更
- 2-0001_Baseロールで使用するregistryのpathの指定方法の変更

# Release 1.0.1
## 新機能および改良点
## バグフィックスやその他変更点
- Serverspecの1-0102_apacheロールにて、パラメータ`is_default_charset_utf8`の指定の有無に関わらず、`AddDefaultCharset`の値を確認する試験が走ってしまう不具合を修正。

# Release 1.0.0
## 新機能および改良点
## バグフィックスやその他変更点
- 初期リリース
