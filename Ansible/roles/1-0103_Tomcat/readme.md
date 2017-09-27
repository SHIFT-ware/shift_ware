# RoleName : 1-0103_Tomcat

---------------

## Synopsis
Apache Tomcatの設定をします。本ロールではApache Tomcatのバージョン7.0.75を前提として実装しています。

## Tested platforms
platform | ver | 
-------- |-----|
Red Hat Enterprise Linux|6.5

## Tasks
- サービス起動ユーザ所属グループ設定
- サービス起動ユーザ設定
- Tomcatがインストール済みか確認
- Tomcatのインストール(必要な場合のみ)
- 初期アプリケーションの削除(指定した場合のみ)
- マネージャアプリケーションの削除(指定した場合のみ)
- 全体設定server.xmlの編集
- 起動時シェル変数設定setenv.shの編集
- Tomcat内部ユーザ設定tomcat-users.xmlの編集
- Tomcatインストールディレクトリの所有者変更
- サービス登録(指定した場合のみ)
- Tomcatの起動・停止

## Usage
### How to set parameter 
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
192.168.127.101:
  Tomcat:
    state: started                                           # サービスの稼働状態
    install_dir: /usr/local/tomcat                           # インストールディレクトリ
    tarball: apache-tomcat-7.0.75.tar.gz                     # Tomcatのアーカイブファイル
    connector:                                               # Connectorタグ
      http:                                                  # HTTPコネクタ
        port: 8080                                           # port
        protocol: HTTP/1.1                                   # protocol
        redirectPort: 8443                                   # redirectPort
        acceptCount: 100                                     # acceptCount
        connectionTimeout: 20000                             # connectionTimeout
        keepAliveTimeout: 60000                              # keepAliveTimeout
        maxConnections: 8192                                 # maxConnections
        maxKeepAliveRequests: 100                            # maxKeepAliveRequests
        maxThreads: 200                                      # maxThreads
        minSpareThreads: 10                                  # minSpareThreads
      ajp:                                                   # AJPコネクタ
        port: 8009                                           # port
        protocol: AJP/1.3                                    # protocol
        redirectPort: 8443                                   # redirectPort
        acceptCount: 100                                     # acceptCount
        connectionTimeout: 60000                             # connectionTimeout
        keepAliveTimeout: 60000                              # keepAliveTimeout
        maxConnections: 8192                                 # maxConnections
        maxThreads: 200                                      # maxThreads
        minSpareThreads: 10                                  # minSpareThreads
        enableLookups: true                                  # enableLookups
    engine:                                                  # Engineタグ
      jvmRoute: tomcat01                                     # jvmRoute
      defaultHost: localhost                                 # defaultHost
    cluster:                                                 # Clusterタグ
      channelSendOptions: 6                                  # channelSendOptions
      channelStartOptions: 3                                 # channelStartOptions
      manager:                                               # Managerタグ
        type: BackupManager                                  # Managerタイプ
        notifyListenersOnReplication: "true"                 # notifyListenersOnReplication
        mapSendOptions: "6"                                  # mapSendOptions
      receiver:                                              # Receiverタグ
        address: 192.168.127.101                             # address
        port: 4000                                           # port
        selectorTimeout: 5000                                # selectorTimeout
        maxThreads: 6                                        # maxThreads
      member:                                                # Memberタグ
        enable_multicast: no                                 # Multicastでのレプリケーション有効無効
        members:
          - host: 192.168.127.102                            # host(enable_multicastがnoのときのみ)
            port: 4000                                       # port
            domain: tomcat_cluster                           # domain(enable_multicastがnoのときのみ)
            uniqueId: "{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}"    # uniqueId(enable_multicastがnoのときのみ)
#        enable_multicast: yes                               # Multicastでのレプリケーション有効無効
#        members:
#          - address: 228.0.0.4                              # address(enable_multicastがyesのときのみ)
#            port: 45564                                     # port
#            frequency: 500                                  # frequency(enable_multicastがyesのときのみ)
#            dropTime: 3000                                  # dropTime(enable_multicastがyesのときのみ)
    envs:                                                    # setenv.shに記載する変数
      catalina_home: /usr/local/tomcat                       # CATALINA_HOME
      catalina_base: /usr/local/tomcat                       # CATALINA_BASE
      catalina_out: /usr/local/tomcat/logs/catalina.out      # CATALINA_OUT
      java_home: /usr/lib/jvm/jre-1.7.0                      # JAVA_HOME
    catalina_opts:                                           # CATALINA_OPTS
      server: yes                                            # server
      Xms: 256                                               # Xms
      Xmx: 512                                               # Xmx
#      MaxMetaspaceSize: 256                                 # MaxMetaspaceSize(openJDK 1.8.0利用時のみ)
      MaxPermSize: 256                                       # MaxPermSize
      PermSize: 128                                          # PermSize
      Xss: 256                                               # Xss
      NewSize: 128                                           # NewSize
      MaxNewSize: 256                                        # MaxNewSize
      TargetSurvivorRatio: 50                                # TargetSurvivorRatio
#      MetaspaceSize: 128                                    # MetaspaceSize(openJDK 1.8.0利用時のみ)
      InitialTenuringThreshold: 0                            # InitialTenuringThreshold
      MaxTenuringThreshold: 0                                # MaxTenuringThreshold
      SurvivorRatio: 65632                                   # SurvivorRatio
      UseConcMarkSweepGC: yes                                # UseConcMarkSweepGC
      UseParNewGC: yes                                       # UseParNewGC
      CMSParallelRemarkEnabled: yes                          # CMSParallelRemarkEnabled
      CMSConcurrentMTEnabled: yes                            # CMSConcurrentMTEnabled
      CMSIncrementalMode: yes                                # CMSIncrementalMode
      CMSIncrementalPacing: yes                              # CMSIncrementalPacing
      CMSIncrementalDutyCycleMin: 0                          # CMSIncrementalDutyCycleMin
      CMSIncrementalDutyCycle: 10                            # CMSIncrementalDutyCycle
      CMSClassUnloadingEnabled: yes                          # CMSClassUnloadingEnabled
      CMSInitiatingOccupancyFraction: 60                     # CMSInitiatingOccupancyFraction
      UseParallelGC: yes                                     # UseParallelGC
      UseParallelOldGC: yes                                  # UseParallelOldGC
      UseTLAB: yes                                           # UseTLAB
      ResizeTLAB: yes                                        # ResizeTLAB
      DisableExplicitGC: yes                                 # DisableExplicitGC
      UseCompressedOops: yes                                 # UseCompressedOops
      UseStringCache: yes                                    # UseStringCache
      UseAdaptiveGCBoundary: yes                             # UseAdaptiveGCBoundary
      UseBiasedLocking: yes                                  # UseBiasedLocking
      HeapDumpOnOutOfMemoryError: yes                        # HeapDumpOnOutOfMemoryError
      OptimizeStringConcat: yes                              # OptimizeStringConcat
      Xloggc: /usr/local/tomcat/logs/tomcat-gc.log           # Xloggc
      PrintGCDetails: yes                                    # PrintGCDetails
      PrintGCDateStamps: yes                                 # PrintGCDateStamps
    manager:                                                 # マネージャアプリケーション
      enable: yes                                            # マネージャアプリケーションの有効
      user: admin                                            # 管理者ユーザ
      password: p@ssw0rd                                     # 管理者ユーザパスワード
      enable_roles:                                          # 管理者ユーザロール
        gui: yes                                             # 管理ユーザロールmanager-guiの有効/無効
        status: yes                                          # 管理ユーザロールmanager-statusの有効/無効
        script_role: yes                                     # 管理ユーザロールmanager-scriptの有効/無効
        jmx_role: yes                                        # 管理ユーザロールmanager-jmxの有効/無効
    initial_apps:                                            # 初期配置アプリケーション
      enable: yes                                            # 初期配置アプリケーションの有効
    init_script:                                             # 起動スクリプト設定
      enable: no                                             # スクリプトの配置/未配置
      service:                                               # サービス設定
        state: started                                       # サービス起動状態
        enabled: yes                                         # サービスの自動起動設定
    exec_groups:                                             # tomcat実行ユーザ所属グループ
      primary:                                               # tomcat実行ユーザ所属プライマリグループ
        name: tomcat                                         # グループ名
        gid: 1000                                            # gid
      secondary:                                             # tomcat実行ユーザ所属セカンダリグループ
        - name: test1                                        # グループ名
          gid: 1001                                          # gid
        - name: test2                                        # グループ名
          gid: 1002                                          # gid
    exec_user:                                               # tomcat実行ユーザ
      name: tomcat                                           # ユーザ名
      uid: 1000                                              # uid
      home_dir: /usr/local/tomcat                            # ホームディレクトリ
      shell: /bin/bash                                       # ログインシェル
      password: p@ssw0rd                                     # パスワード
```

### Please put package files
本ロールでTomcatをインストールするために、Tomcat本体のtarボールを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

* Shift_Env/files

### How to run 
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none

## Caution
- 本ロールを実行し、Tomcatを起動するためにはJDKが必要となります。事前にインストールしてください。なお、JDKのインストールには1-0105_openJDKがご利用いただけます
