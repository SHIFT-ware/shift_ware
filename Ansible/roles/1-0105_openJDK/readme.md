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
  packages:                                                              # インストールパッケージ
     - name: "alsa-lib-1.0.22-3.el6.x86_64.rpm"
     - name: "flac-1.2.1-6.1.el6.x86_64.rpm"
     - name: "fontconfig-2.8.0-3.el6.x86_64.rpm"
     - name: "freetype-2.3.11-14.el6_3.1.x86_64.rpm"
     - name: "giflib-4.1.6-3.1.el6.x86_64.rpm"
     - name: "java-1.7.0-openjdk-1.7.0.45-2.4.3.3.el6.x86_64.rpm"
     - name: "java-1.7.0-openjdk-devel-1.7.0.45-2.4.3.3.el6.x86_64.rpm"
     - name: "jline-0.9.94-0.8.el6.noarch.rpm"
     - name: "jpackage-utils-1.7.5-3.12.el6.noarch.rpm"
     - name: "libasyncns-0.8-1.1.el6.x86_64.rpm"
     - name: "libfontenc-1.0.5-2.el6.x86_64.rpm"
     - name: "libICE-1.0.6-1.el6.x86_64.rpm"
     - name: "libjpeg-turbo-1.2.1-1.el6.x86_64.rpm"
     - name: "libogg-1.1.4-2.1.el6.x86_64.rpm"
     - name: "libpng-1.2.49-1.el6_2.x86_64.rpm"
     - name: "libSM-1.2.1-2.el6.x86_64.rpm"
     - name: "libsndfile-1.0.20-5.el6.x86_64.rpm"
     - name: "libvorbis-1.2.3-4.el6_2.1.x86_64.rpm"
     - name: "libX11-1.5.0-4.el6.x86_64.rpm"
     - name: "libX11-common-1.5.0-4.el6.noarch.rpm"
     - name: "libXau-1.0.6-4.el6.x86_64.rpm"
     - name: "libxcb-1.8.1-1.el6.x86_64.rpm"
     - name: "libXext-1.3.1-2.el6.x86_64.rpm"
     - name: "libXfont-1.4.5-2.el6.x86_64.rpm"
     - name: "libXi-1.6.1-3.el6.x86_64.rpm"
     - name: "libXrender-0.9.7-2.el6.x86_64.rpm"
     - name: "libXtst-1.2.1-2.el6.x86_64.rpm"
     - name: "pulseaudio-libs-0.9.21-14.el6_3.x86_64.rpm"
     - name: "rhino-1.7-0.7.r2.2.el6.noarch.rpm"
     - name: "ttmkfdir-3.0.9-32.1.el6.x86_64.rpm"
     - name: "tzdata-java-2013g-1.el6.noarch.rpm"
     - name: "xorg-x11-fonts-Type1-7.2-9.1.el6.noarch.rpm"
     - name: "xorg-x11-font-utils-7.2-11.el6.x86_64.rpm"
```

### Please put package files
本ロールでopenjdk(およびopenjdk-devel)をインストールするために、openjdk(およびopenjdk-devel)本体のパッケージおよびその依存パッケージを以下のディレクトリに配置してください。また配置したパッケージ名をhost_varsにも記載ください。

- Shift_Env/files

### How to run
ロールの実行方法については[こちら](https://github.com/SHIFT-ware/shift_ware/wiki/%E5%AE%9F%E8%A1%8C%E6%96%B9%E6%B3%95#ansible-%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AE%E5%AE%9F%E8%A1%8C)をご覧ください。

## Dependent Roles
- none
