#!/bin/sh -x

cd ${WORKSPACE}/shift

# ServerspecがNG=4
echo 01
grep -E "NG=4," Shift_Log/Shift.2/Serverspec_Result_192.168.127.31.csv
result01=$?

echo 02
grep -E "NG=4," Shift_Log/Shift.2/Serverspec_Result_192.168.127.41.csv
result02=$?


# Ansibleの結果判定
echo 03
grep -E "192\.168\.127\.31\s*:\s*ok=[0-9]{1,3}\s*changed=3\s*unreachable=0\s*failed=0" Shift_Log/Shift.1/Ansible.log
result03=$?

echo 04
grep -E "192\.168\.127\.41\s*:\s*ok=[0-9]{1,3}\s*changed=3\s*unreachable=0\s*failed=0" Shift_Log/Shift.1/Ansible.log
result04=$?


# Serverspecの結果判定
echo 05
grep -E "NG=0," Shift_Log/Serverspec_Result_192.168.127.31.csv
result05=$?

echo 06
grep -E "NG=0," Shift_Log/Serverspec_Result_192.168.127.41.csv
result06=$?

exit $((result01 || result02 || result03 || result04 || result05 || result06 ))

