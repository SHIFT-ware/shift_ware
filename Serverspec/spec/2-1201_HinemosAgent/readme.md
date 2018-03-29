# RoleName : 2-1201_HinemosAgent

---------------

## Synopsis
HinemosAgentのインストール、初期設定を確認します。リソース監視を行う為の SNMP Service の設定確認も行います。  
本ロールは``HinemosAgent 6.0.2``を前提として実装しています。

### Tested platforms

platform | ver | 
-------- |-----|
WindowsServer|2012R2
WindowsServer|2016

### Tasks
- SNMPサービス設定
  - コミュニティ名確認
  - SNMPパケットを受け取るホストの確認
- HinemosAgentのインストール
  - インストールディレクトリの有無を確認
  - プログラムのバージョン確認
  - HinemosマネージャのIP指定を確認 
- サービス設定
  - HinemosAgent
      - 起動状態確認
      - スタートアップの種類確認
      - ログオンユーザの確認
  - SNMP
      - 起動状態確認
      - スタートアップの種類確認
      - ログオンユーザの確認
- Hinemosマネージャへのノード情報の登録有無確認

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yaml
192.168.127.101:
  HinemosAgent:
    version: '6.0.2'                          # Hinemosエージェントのバージョン
    install_path: 'C:\Program Files (x86)\Hinemos\Agent6.0.2' # Hinemosエージェントのインストールパス
    service_HinemosAgent:                     # Hinemosエージェントのサービス設定
      name: 'Hinemos_6.0_Agent'               # サービス名
      state: started                          # サービス状態
      start_mode: auto                        # 自動起動設定
      start_user: 'LocalSystem'               # ログオンアカウント名
    service_SNMP:                             # SNMP Serviceのサービス設定
      state: started                          # サービス状態
      start_mode: auto                        # 自動起動設定
      start_user: 'LocalSystem'               # ログオンアカウント名
    community:
      name: 'public'                          # コミュニティ名
    hinemos_manager:                          # Hinemosマネージの情報
      ip: '192.168.127.1'                     # HinemosマネージャのIPアドレス
      login_user: 'hinemos'                   # Hinemosマネージャのログインユーザ
      login_pass: 'hinemos'                   # Hinemosマネージャのログインパスワード
    hinemos_node:                             # Hinemosマネージャへ登録したノード情報。ノード情報チェックが不要な場合は定義しない。                           
      ip: '192.168.127.101'                   # 登録したノードのIPアドレス          
      facility_id: 'host1'                    # 登録したノードのファシリティID
      facility_name: 'HOST NAME 1'            # 登録したノードのファシリティ名
      role: 'ALL_USERS'                       # 登録したノードに割り当てたスコープのファシリティID
      scope_id: 'TEST'                        # 登録したノードのオーナーロールID
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Caution
- Hinemosマネージャへのノード情報チェックにはあらかじめコントロールマシンにPythonのsudsパッケージをインストールしておく必要があります。
　sudsパッケージはShiftContribパッケージと一緒にインストールされます。ShiftContribパッケージの導入方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をごらんください。

### Dependent Roles
- none
