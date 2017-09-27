#!/bin/sh

cd ${WORKSPACE}/shift

PATH=$PATH:$HOME/bin

export PATH
source ~/Ansible/hacking/env-setup
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# これより下にSHIFT実行部分を記述
Shift_Bin/Spec-play.sh run
result01=$?


exit $((result01))
