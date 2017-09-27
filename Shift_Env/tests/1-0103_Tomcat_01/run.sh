#!/bin/sh

cd ${WORKSPACE}/shift

PATH=$PATH:$HOME/bin

export PATH
source ~/Ansible/hacking/env-setup
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# これより下にSHIFT実行部分を記述
sed -i "/\[1-0105_openJDK/a 192.168.127.31 ansible_user=shift ansible_ssh_pass=p@ssw0rd" Shift_Env/Ansible.1.inventory

Shift_Bin/Ansible-play.sh run
result01=$?

sleep 30

Shift_Bin/Spec-play.sh run
result02=$?

exit $((result01 || result02))
