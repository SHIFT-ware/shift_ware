# RoleName : 1-1201_HinemosAgent

---------------

## Synopsis
HinemosAgentのインストール、初期設定を確認します。本ロールは``HinemosAgent 6.0.2``を前提として実装しています。

## Tested platforms
platform | ver |
-------- |---|
Redhat Enterprise Linux|6.5
Redhat Enterprise Linux|7.1

### Tasks
- Hinemosエージェントのインストール有無
- Hinemosエージェントの設定ファイルへのHinemosマネージャのIPアドレス設定
- サービス設定
  - 起動状態が指定通りであること
  - 自動起動の有無が指定通りであること
- Hinemosマネージャへのノード情報の登録有無

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yaml
192.168.127.101:
  HinemosAgent:
    installer: 'hinemos-6.0-agent-6.0.2-1.el.noarch.rpm'  # インストールパッケージのファイル名
    service_HinemosAgent:             
      name: 'hinemos_agent'             # Hinemosエージェントのサービス名
      state: started                    # サービスの状態
      enabled: true                     # 自動起動設定
    community:
      name: 'public'                    # SNMPのコミュニティ名
    hinemos_manager:                    # Hinemosマネージの情報
      ip: '192.168.127.1'               # HinemosマネージャのIPアドレス
      login_user: 'hinemos'             # Hinemosマネージャのログインユーザ
      login_pass: 'hinemos'             # Hinemosマネージャのログインパスワード
    hinemos_node:                       # Hinemosマネージャへ登録したノード情報。ノード情報チェックが不要な場合は定義しない。
      ip: '192.168.127.101'             # 登録したノードのIPアドレス
      facility_id: 'host1'              # 登録したノードのファシリティID
      facility_name: 'HOST NAME 1'      # 登録したノードのファシリティ名
      scope_id: 'TEST'                  # 登録したノードに割り当てたスコープのファシリティID
      role: 'ALL_USERS'                 # 登録したノードのオーナーロールID
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Caution
- Hinemosマネージャへのノード情報チェックにはあらかじめコントロールマシンにPythonのsudsパッケージをインストールしておく必要があります。
　sudsパッケージはShiftContribパッケージと一緒にインストールされます。ShiftContribパッケージの導入方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をごらんください。

### Dependent Roles
- none
