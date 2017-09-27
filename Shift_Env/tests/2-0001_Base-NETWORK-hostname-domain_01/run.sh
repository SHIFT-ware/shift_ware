#!/bin/sh

cd ${WORKSPACE}/shift

PATH=$PATH:$HOME/bin

export PATH
source ~/Ansible/hacking/env-setup
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# DNS設定

python Shift_Env/tests/2-0001_Base-NETWORK-hostname-domain_01/sh/pywinrm.py '192.168.127.141' 'Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses "192.168.127.100"'
python Shift_Env/tests/2-0001_Base-NETWORK-hostname-domain_01/sh/pywinrm.py '192.168.127.151' 'Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses "192.168.127.100"'


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

cp -rf Shift_Env/tests/2-0001_Base-NETWORK-hostname-domain_01/test_case02/host_vars ./Shift_Env/
cp -rf Shift_Env/tests/2-0001_Base-NETWORK-hostname-domain_01/test_case02/properties.yml ./Shift_Env/

Shift_Bin/Ansible-play.sh run
result06=$?

Shift_Bin/Spec-play.sh run
result07=$?


cp -rf Shift_Env/tests/2-0001_Base-NETWORK-hostname-domain_01/test_case03/host_vars ./Shift_Env/
cp -rf Shift_Env/tests/2-0001_Base-NETWORK-hostname-domain_01/test_case03/properties.yml ./Shift_Env/

Shift_Bin/Ansible-play.sh run
result08=$?

Shift_Bin/Spec-play.sh run
result09=$?



exit $((result01 || result02 || result03 || result04 || result05 || result06 || result07 || result08 || result09))
