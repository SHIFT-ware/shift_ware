#!/bin/sh

cd ${WORKSPACE}/shift

PATH=$PATH:$HOME/bin

export PATH
source ~/Ansible/hacking/env-setup
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# コマンド実行

sshpass -p 'p@ssw0rd' ssh root@192.168.127.41 'sed -i -e "/GATEWAY/d"  /etc/sysconfig/network-scripts/ifcfg-ens161'
sshpass -p 'p@ssw0rd' ssh root@192.168.127.41 'service network restart'

sleep 10


# これより下にSHIFT実行部分を記述
Shift_Bin/Spec-play.sh run
result01=$?

Shift_Bin/Ansible-play.sh run
result02=$?

Shift_Bin/Spec-play.sh run
result03=$?

Shift_Bin/Ansible-play.sh run
result04=$?

Shift_Bin/Spec-play.sh run
result05=$?

exit $((result01 || result02 || result03 || result04 || result05 ))


