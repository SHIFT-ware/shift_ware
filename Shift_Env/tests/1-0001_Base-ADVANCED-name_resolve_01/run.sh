#!/bin/sh

cd ${WORKSPACE}/shift

PATH=$PATH:$HOME/bin

export PATH
source ~/Ansible/hacking/env-setup
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# DNSのテストのためRHEL7のインターフェースを追加
sshpass -p 'p@ssw0rd' ssh root@192.168.127.41 'sh ' < Shift_Env/tests/1-0001_Base-ADVANCED-name_resolve_01/sh/set_interface.sh 

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

cp -rf Shift_Env/tests/1-0001_Base-ADVANCED-name_resolve_01/test_case02/host_vars ./Shift_Env/
cp -rf Shift_Env/tests/1-0001_Base-ADVANCED-name_resolve_01/test_case02/properties.yml ./Shift_Env/

Shift_Bin/Spec-play.sh run
result06=$?

Shift_Bin/Ansible-play.sh run
result07=$?

Shift_Bin/Spec-play.sh run
result08=$?

exit $((result01 || result02 || result03 || result04 || result05 || result06 || result07 || result08))
