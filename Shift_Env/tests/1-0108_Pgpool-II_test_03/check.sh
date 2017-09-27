#!/bin/sh

cd ${WORKSPACE}/shift

echo "----RHEL6の実行結果----"
cat Shift_Log/Ansible.log | grep -e "changed=0" | grep -e "192.168.127.31"
result01=$?

echo "----RHEL7の実装はありません...----"
result02=$?

exit $((result01 || result02))

