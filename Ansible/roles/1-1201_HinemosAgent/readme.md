# RoleName : 1-1201_HinemosAgent

---------------

## Synopsis

Hinemosエージェントの状態(インストール、設定)を定義します。 また、エージェントを導入したマシンの情報をノードとしてHinemosマネージャに登録します。
本ロールは``HinemosAgent 6.0.2``を前提として実装しています。

### Tested platforms

platform | ver | 
-------- |-----|
Red Hat Enterprise Linux|6.5
Red Hat Enterprise Linux|7.1

### Tasks
- HinemosAgentのインストール
- サービス設定
  - サービスのスタートアップ種類
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
    package: 'hinemos-6.0-agent'        # インストールパッケージ名
    service_HinemosAgent:               # サービス設定
      name: 'hinemos_agent'             # サービス名
      state: started                    # サービスの状態
      enabled: true                     # 自動起動設定
    community:
      name: 'public'                    # SNMPのコミュニティ名
    hinemos_manager:                    # Hinemosマネージの情報
      ip: '192.168.127.1'               # HinemosマネージャのIPアドレス
      login_user: 'hinemos'             # Hinemosマネージャのログインユーザ
      login_pass: 'hinemos'             # Hinemosマネージャのログインパスワード
    hinemos_node:                       # Hinemosマネージャへ登録するノード情報。登録が不要な場合は定義しない。
      ip: '192.168.127.101'              # 登録するノードのIPアドレス(SNMPによるノードサーチ時に使用)
      facility_id: 'host1'              # 登録するノードのファシリティID
      facility_name: 'HOST NAME 1'      # 登録するノードのファシリティ名
      scope_id: 'TEST'                  # 登録するノードに割り当てるスコープのファシリティID
      role: 'ALL_USERS'                 # 登録するノードのオーナーロールID
```

### Please put package files

本ロールではHinemosAgentをyumでインストールします。tools/1-9908_RepoUp, tools/1-9910_RepofilePut を使って、yumリポジトリからインストーラパッケージ（hinemos-6.0-agent-6.0.2-1.el.noarch.rpm）を取得できるようにしておいてください。

### How to run  
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

### Dependent Roles
- none

## Caution
- Hinemosエージェントの実行に OpenJDK が必要ですので、1-0105_openJDK もしくは手動で事前にインストールしてください。
- Hinemosマネージャにノードを登録する際にターゲットサーバへSNMPでアクセスします。1-0001_Base もしくは手動で net-snmp パッケージを事前に導入しておくことを推奨します。
- Hinemosマネージャにノード情報を登録するにはあらかじめコントロールマシンにPythonのsudsパッケージをインストールしておく必要があります。
　sudsパッケージはShiftContribパッケージと一緒にインストールされます。ShiftContribパッケージの導入方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をごらんください。
