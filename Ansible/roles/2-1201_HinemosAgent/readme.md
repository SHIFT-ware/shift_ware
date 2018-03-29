# RoleName : 2-1201_HinemosAgent

---------------

## Synopsis
Hinemosエージェントの状態(インストール、設定)を定義します。リソース監視を行う為の SNMP Service の状態も定義します。  
また、エージェントを導入したマシンの情報をノードとしてHinemosマネージャに登録します。
本ロールは``HinemosAgent 6.0.2``を前提として実装しています。

### Tested platforms
platform | ver | 
-------- |-----|
WindowsServer|2012R2
WindowsServer|2016

### Tasks
- Windowsファイアーウォールの設定
  - Hinemosエージェントの通信ポート(デフォルト UDP 24005)の開放
- Oracle JDKのインストール
- SNMPサービス設定
  - SNMPサービスのインストール
  - コミュニティ名の設定
  - SNMPパケットを受け取るホスト
- HinemosAgentのインストール
  - インストール確認
  - 一時ディレクトリの作成
  - インストーラ配布
  - HinemosAgentインストール
  - 一時ディレクトリ削除
  - SNMPサービスの再起動
  - HinemosAgentのサービス登録
- サービス設定
  - Hinemos
      - サービスのスタートアップ種類
      - サービスログオンアカウントの設定
      - サービスの起動/停止
  - SNMP
      - サービスのスタートアップ種類
      - サービスログオンアカウントの設定
      - サービスの起動/停止
- Hinemosマネージャへのノード情報登録	
  - SNMPによるノードサーチ	
  - ノード情報を登録	
  - 登録したノードへの既存スコープ割り当て

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yaml
192.168.127.101:
  HinemosAgent:
    jdk_installer: 'jdk-8u161-windows-x64.exe'                # Oracle JDKのインストーラのファイル名
    jdk_install_path: 'C:\Program Files\Java\jdk1.8.0_161'    # Oracle JDKのインストール先ディレクトリ
    installer: 'HinemosAgentInstaller-6.0.2_win.msi'          # Hinemosエージェントのインストーラのファイル名
    install_path: 'C:\Program Files (x86)\Hinemos\Agent6.0.2' # Hinemosエージェントのインストール先ディレクトリ
    firewall_port: '24005'                          # Windowsファイアーウォールで開放する通信ポート(デフォルト UDP 24005)の開放
    firewall_profiles: 'public'                     # Windowsファイアーウォールで通信ポートの開放ルールを適用するプロファイル(カンマ区切りで複数指定可)
    service_HinemosAgent:                           # Hinemosエージェントのサービス設定
      name: 'Hinemos_6.0_Agent'                     # サービス名
      state: started                                # サービスの状態
      start_mode: auto                              # 自動起動設定
      logon_account: 'LocalSystem' ※1              # ログオンアカウント名
      logon_pass: '$null'          ※2              # ログオンアカウントのパスワード
    service_SNMP:                                   # SNMP Serviceのサービス設定
      state: started                                # サービスの状態
      start_mode: auto                              # 自動起動設定
      logon_account: 'LocalSystem' ※1              # ログオンアカウント名
      logon_pass:                  ※2              # ログオンアカウントのパスワード
    community:
      name: 'public'                                # コミュニティ名
    hinemos_manager:                                # Hinemosマネージャの情報
      ip: '192.168.127.1'                           # HinemosマネージャのIPアドレス
      login_user: 'hinemos'                         # Hinemosマネージャのログインユーザ
      login_pass: 'hinemos'                         # Hinemosマネージャのログインパスワード
    hinemos_node:                                   # Hinemosマネージャへ登録するノード情報。登録が不要な場合は定義しない。
      ip: '192.168.127.101'                         # 登録するノードのIPアドレス(SNMPによるノードサーチ時に使用)
      facility_id: 'host1'                          # 登録するノードのファシリティID
      facility_name: 'HOST NAME 1'                  # 登録するノードのファシリティ名
      scope_id: 'TEST'                              # 登録するノードに割り当てるスコープのファシリティID
      role: 'ALL_USERS'                             # 登録するノードのオーナーロールID

※1 デフォルトのログオンアカウントはLocalSystemになります。
    別のアカウントを指定する場合、「<ドメイン名>\<アカウント名>」を記載下さい。
 　  例：.\test (ローカルのtestアカウントを設定する場合)

※2 LocalSystemの場合は空文字（何も入力しない）もしくは$nullとして下さい。
　  別のアカウントの場合はアカウントのパスワードを記載下さい。
```

### Please put package files
本ロールでHinemosエージェントをインストールするために、HinemosエージェントとOracle JDKのインストーラを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

* Shift_Env/files

### How to run  
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

### Dependent Roles
- none

## Caution
- SNMP Serviceのインストールおよび設定も行われます。
  - 追加するコミュニティの権利は「読み取り」で設定されます。
  - SNMPパケットを受け付けるホストはローカルホストとHinemosマネージャが設定されます。
- サービスのログオンアカウントを変更する場合、対象アカウントが事前に存在する必要があります。アカウントの作成、およびローカルセキュリティポリシーにて「サービスとしてログオン」を手動で設定してからロールを実行下さい。
- Hinemosエージェントの実行に Oracle JDK が必要ですので事前にダウンロードして、Hinemosエージェントのインストーラと同じく配置してください。
- Hinemosマネージャにノード情報を登録するにはあらかじめコントロールマシンにPythonのsudsパッケージをインストールしておく必要があります。
　sudsパッケージはShiftContribパッケージと一緒にインストールされます。ShiftContribパッケージの導入方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をごらんください。

