#!/bin/sh

nmcli c s ens192

nmcli c m ens192 connection.autoconnect yes
nmcli c m ens192 ipv4.method manual ipv4.addresses 10.10.10.10
