# RoleName : 1-0105_openJDK

---------------

## Synopsis
openJDKのインストールが行われているか、チェックします。  
このロールはOpenJDKのバージョン1.7.0および1.8.0を前提として実装しています。

## Tested platforms

platform | ver |
-------- |---|
Redhat Enterprise Linux|6.5

## Tasks
本ロールでは以下の項目をテストします。

* openjdkのパッケージがインストールされていること
* openjdk-develのパッケージがインストールされていること

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
192.168.127.101:                                   # ターゲットのIP
  operating_system: Linux                          # ターゲットのOS
  openjdk:
    version: '1.7.0'                               # OpenJDKのバージョン
    install_devel: yes                             # develパッケージをインストールしたか
```

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#serverspec%E3%83%86%E3%82%B9%E3%83%88%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent roles
- none
