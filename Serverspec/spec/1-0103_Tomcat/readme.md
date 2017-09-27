# RoleName : 1-0103_Tomcat

---------------

## Synopsis
Apache Tomcatの設定が正しく行われているか、チェックします。本ロールはApache Tomcatのバージョン7.0.75を前提として実装しています。

## Tested platforms

platform | ver |
-------- |---|
Redhat Enterprise Linux|6.5

## Tasks
本ロールでは以下の項目をテストします。
* tomcatプロセス
    * プロセスが稼働状態が指定通りであること
    * CATALINA_OPTSの-serverの値が指定通りであること
    * CATALINA_OPTSのXmsの値が指定通りであること
    * CATALINA_OPTSのXmxの値が指定通りであること
    * CATALINA_OPTSのMaxMetaspaceSizeの値が指定通りであること
    * CATALINA_OPTSのTargetSurvivorRatioの値が指定通りであること
    * CATALINA_OPTSのMetaspaceSizeの値が指定通りであること
    * CATALINA_OPTSのInitialTenuringThresholdの値が指定通りであること
    * CATALINA_OPTSのMaxTenuringThresholdの値が指定通りであること
    * CATALINA_OPTSのSurvivorRatioの値が指定通りであること
    * CATALINA_OPTSのUseConcMarkSweepGCの値が指定通りであること
    * CATALINA_OPTSのUseParNewGCの値が指定通りであること
    * CATALINA_OPTSのCMSParallelRemarkEnabledの値が指定通りであること
    * CATALINA_OPTSのCMSConcurrentMTEnabledの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalModeの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalPacingの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalDutyCycleMinの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalDutyCycleの値が指定通りであること
    * CATALINA_OPTSのCMSClassUnloadingEnabledの値が指定通りであること
    * CATALINA_OPTSのCMSInitiatingOccupancyFractionの値が指定通りであること
    * CATALINA_OPTSのUseParallelGCの値が指定通りであること
    * CATALINA_OPTSのUseParallelOldGCの値が指定通りであること
    * CATALINA_OPTSのUseTLABの値が指定通りであること
    * CATALINA_OPTSのResizeTLABの値が指定通りであること
    * CATALINA_OPTSのDisableExplicitGCの値が指定通りであること
    * CATALINA_OPTSのUseCompressedOopsの値が指定通りであること
    * CATALINA_OPTSのUseStringCacheの値が指定通りであること
    * CATALINA_OPTSのUseAdaptiveGCBoundaryの値が指定通りであること
    * CATALINA_OPTSのUseBiasedLockingの値が指定通りであること
    * CATALINA_OPTSのHeapDumpOnOutOfMemoryErrorの値が指定通りであること
    * CATALINA_OPTSのOptimizeStringConcatの値が指定通りであること
    * CATALINA_OPTSのXloggcの値が指定通りであること
    * CATALINA_OPTSのPrintGCDetailsの値が指定通りであること
    * CATALINA_OPTSのPrintGCDateStampsの値が指定通りであること
* tomcatのインストールディレクトリ
    * 存在すること
    * 所有者が指定通りであること
* server.xml
    * Connectorタグ
        * HTTPコネクタ
            * portが指定通りであること 
            * protocolが指定通りであること 
            * redirectPortが指定通りであること 
            * acceptCountが指定通りであること 
            * connectionTimeoutが指定通りであること 
            * keepAliveTimeoutが指定通りであること 
            * maxConnectionsが指定通りであること 
            * maxKeepAliveRequestsが指定通りであること 
            * maxThreadsが指定通りであること 
            * minSpareThreadsが指定通りであること 
        * AJPコネクタ
            * portが指定通りであること 
            * protocolが指定通りであること 
            * redirectPortが指定通りであること 
            * acceptCountが指定通りであること 
            * connectionTimeoutが指定通りであること 
            * keepAliveTimeoutが指定通りであること 
            * maxConnectionsが指定通りであること 
            * maxThreadsが指定通りであること 
            * minSpareThreadsが指定通りであること 
            * enableLookupsが指定通りであること 
    * Engineタグ
        * defaultHostが指定通りであること
        * jvmRouteが指定通りであること
    * Clusterタグ
        * channelSendOptionsが指定通りであること
        * channelStartOptionsが指定通りであること
        * Managerタグ
            * classNameが指定通りであること
            * notifyListenersOnReplicationが指定通りであること
            * mapSendOptionsが指定通りであること
        * Receiverタグ
            * addressが指定通りであること
            * portが指定通りであること
            * selectorTimeoutがであること
            * maxThreadsがであること
        * Membershipタグ
            * addressが指定通りであること
            * portが指定通りであること
            * frequencyが指定通りであること
            * dropTimeが指定通りであること
        * Memberタグ
            * hostが指定通りであること
            * portが指定通りであること
            * domainが指定通りであること
            * uniqueId指定通りであること
* setenv.sh
    * CATALINA_HOMEが指定通りであること
    * CATALINA_BASEが指定通りであること
    * CATALINA_OUTが指定通りであること
    * JAVA_HOMEが指定通りであること
    * CATALINA_OPTSの-serverの値が指定通りであること
    * CATALINA_OPTSのXmsの値が指定通りであること
    * CATALINA_OPTSのXmxの値が指定通りであること
    * CATALINA_OPTSのMaxMetaspaceSizeの値が指定通りであること
    * CATALINA_OPTSのTargetSurvivorRatioの値が指定通りであること
    * CATALINA_OPTSのMetaspaceSizeの値が指定通りであること
    * CATALINA_OPTSのInitialTenuringThresholdの値が指定通りであること
    * CATALINA_OPTSのMaxTenuringThresholdの値が指定通りであること
    * CATALINA_OPTSのSurvivorRatioの値が指定通りであること
    * CATALINA_OPTSのUseConcMarkSweepGCの値が指定通りであること
    * CATALINA_OPTSのUseParNewGCの値が指定通りであること
    * CATALINA_OPTSのCMSParallelRemarkEnabledの値が指定通りであること
    * CATALINA_OPTSのCMSConcurrentMTEnabledの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalModeの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalPacingの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalDutyCycleMinの値が指定通りであること
    * CATALINA_OPTSのCMSIncrementalDutyCycleの値が指定通りであること
    * CATALINA_OPTSのCMSClassUnloadingEnabledの値が指定通りであること
    * CATALINA_OPTSのCMSInitiatingOccupancyFractionの値が指定通りであること
    * CATALINA_OPTSのUseParallelGCの値が指定通りであること
    * CATALINA_OPTSのUseParallelOldGCの値が指定通りであること
    * CATALINA_OPTSのUseTLABの値が指定通りであること
    * CATALINA_OPTSのResizeTLABの値が指定通りであること
    * CATALINA_OPTSのDisableExplicitGCの値が指定通りであること
    * CATALINA_OPTSのUseCompressedOopsの値が指定通りであること
    * CATALINA_OPTSのUseStringCacheの値が指定通りであること
    * CATALINA_OPTSのUseAdaptiveGCBoundaryの値が指定通りであること
    * CATALINA_OPTSのUseBiasedLockingの値が指定通りであること
    * CATALINA_OPTSのHeapDumpOnOutOfMemoryErrorの値が指定通りであること
    * CATALINA_OPTSのOptimizeStringConcatの値が指定通りであること
    * CATALINA_OPTSのXloggcの値が指定通りであること
    * CATALINA_OPTSのPrintGCDetailsの値が指定通りであること
    * CATALINA_OPTSのPrintGCDateStampsの値が指定通りであること
* マネージャアプリケーション群が存在が指定通りであること
* マネージャアプリケーション設定
    * 管理者ユーザが指定通りであること
    * 管理者ユーザのパスワードが指定通りであること
    * 管理者ユーザのロールmanager-guiの有効無効が指定通りであること
    * 管理者ユーザのロールmanager-statusの有効無効が指定通りであること
    * 管理者ユーザのロールmanager-scriptの有効無効が指定通りであること
    * 管理者ユーザのロールmanager-jmxの有効無効が指定通りであること
* 初期アプリケーション群が存在が指定通りであること
* tomcat実行ユーザ所属グループ
    * プライマリグループ
        * グループが存在すること
        * gidが指定通りであること
    * セカンダリグループ
        * グループが存在すること
        * gidが指定通りであること
* tomcat実行ユーザ
    * tomcat実行ユーザが存在すること
    * tomcat実行ユーザのuidが指定通りであること
    * tomcat実行ユーザの所属プライマリグループが指定通りであること
    * tomcat実行ユーザの所属セカンダリグループがが指定通りであること
    * tomcat実行ユーザのホームディレクトリが指定通りであること
    * tomcat実行ユーザのログインシェルが指定通りであること

## Usage 
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```yaml
192.168.127.101:
  Tomcat:
    state: started                                           # サービスの稼働状態
    install_dir: /usr/local/tomcat                           # インストールディレクトリ
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
          - host: 192.168.127.102                            # host(enable_multicastがnoのときのみ有効)
            port: 4000                                       # port
            domain: tomcat_cluster                           # domain(enable_multicastがnoのときのみ有効)
            uniqueId: "{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}"    # uniqueId(enable_multicastがnoのときのみ有効)
#        enable_multicast: yes                               # Multicastでのレプリケーション有効無効
#        members:
#          - address: 228.0.0.4                              # address(enable_multicastがyesのときのみ有効)
#            port: 45564                                     # port
#            frequency: 500                                  # frequency(enable_multicastがyesのときのみ有効)
#            dropTime: 3000                                  # dropTime(enable_multicastがyesのときのみ有効)
    envs:                                                    # setenv.shに記載する変数
      catalina_home: /usr/local/tomcat                       # CATALINA_HOME
      catalina_base: /usr/local/tomcat                       # CATALINA_BASE
      catalina_out: /usr/local/tomcat/logs/catalina.out      # CATALINA_OUT
      java_home: /usr/lib/jvm/jre-1.7.0                      # JAVA_HOME
    catalina_opts:                                           # CATALINA_OPTS
      server: yes                                            # server
      Xms: 256                                               # Xms
      Xmx: 512                                               # Xmx
      MaxMetaspaceSize: 256                                  # MaxMetaspaceSize
      MaxPermSize: 256                                       # MaxPermSize
      PermSize: 128                                          # PermSize
      Xss: 256                                               # Xss
      NewSize: 128                                           # NewSize
      MaxNewSize: 256                                        # MaxNewSize
      TargetSurvivorRatio: 50                                # TargetSurvivorRatio
      MetaspaceSize: 128                                     # MetaspaceSize
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
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent roles
- none
