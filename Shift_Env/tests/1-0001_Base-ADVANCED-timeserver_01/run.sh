#!/bin/sh

cd ${WORKSPACE}/shift

PATH=$PATH:$HOME/bin

export PATH
source ~/Ansible/hacking/env-setup
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# テスト実行前にコマンドを実行
echo "192.168.127.31"
sshpass -p 'p@ssw0rd' ssh root@192.168.127.31 'sed -i -e "/iburst/d" /etc/ntp.conf'
echo "192.168.127.41"
sshpass -p 'p@ssw0rd' ssh root@192.168.127.41 'sed -i -e "/iburst/d" /etc/ntp.conf'


# これより下にSHIFT実行部分を記述
Shift_Bin/Spec-play.sh run
result01=$?

Shift_Bin/Ansible-play.sh run
result02=$?

echo "192.168.127.31"
sshpass -p 'p@ssw0rd' ssh root@192.168.127.31 'ntpq -p; ntpdate -b 192.168.127.1'
echo "192.168.127.41"
sshpass -p 'p@ssw0rd' ssh root@192.168.127.41 'ntpq -p; ntpdate -b 192.168.127.1'
sleep 20

Shift_Bin/Spec-play.sh run
result03=$?

Shift_Bin/Ansible-play.sh run
result04=$?

Shift_Bin/Spec-play.sh run
result05=$?

exit $((result01 || result02 || result03 || result04 || result05 ))


