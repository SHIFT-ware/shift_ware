#!/bin/sh

cd ${WORKSPACE}/shift

# Serverspecの結果判定
grep -e "192.168.127.31" Shift_Log/Ansible.log | grep -e "failed=0"
result01=$?

exit $result01
