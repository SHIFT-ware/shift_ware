# RoleName : 1-0105_openJDK

---------------

## Synopsis
openJDK のインストールを行います。本ロールはOpenJDKのバージョン1.7.0および1.8.0を前提として実装しています。

## Tested platforms

platform | ver |
-------- |-----|
Red Hat Enterprise Linux|6.5

## Tasks
- openJDKのインストール

## Usage
### How to set parameter
ロールのパラメータの指定方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E6%8C%87%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E9%85%8D%E7%BD%AE)をご覧ください。

パラメータ例:
```
openjdk:
  version: "1.7.0"    # バージョン
  install_devel: yes  # develパッケージをインストールするか
```

### Please put package files
本ロールでopenjdk(およびopenjdk-devel)をインストールするために、openjdk(およびopenjdk-devel)本体のパッケージおよびその依存パッケージを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

- Shift_Env/files

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none
