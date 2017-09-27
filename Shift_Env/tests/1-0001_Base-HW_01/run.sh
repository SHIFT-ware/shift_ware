#!/bin/sh

cd ${WORKSPACE}/shift

PATH=$PATH:$HOME/bin

export PATH
source ~/Ansible/hacking/env-setup
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# これより下にSHIFT実行部分を記述
Shift_Bin/Spec-play.sh run
result01=$?

cp -rf Shift_Env/tests/1-0001_Base-HW_01/test_case02/host_vars ./Shift_Env/
cp -rf Shift_Env/tests/1-0001_Base-HW_01/test_case02/properties.yml ./Shift_Env/

Shift_Bin/Spec-play.sh run
result02=$?

cp -rf Shift_Env/tests/1-0001_Base-HW_01/test_case03/host_vars ./Shift_Env/
cp -rf Shift_Env/tests/1-0001_Base-HW_01/test_case03/properties.yml ./Shift_Env/

Shift_Bin/Spec-play.sh run
result03=$?

exit $(( result01 || result02 || result03 ))
