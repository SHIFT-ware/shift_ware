#!/bin/sh

cd ${WORKSPACE}/shift

# Serverspecの結果判定
grep -E "192\.168\.127\.31.*\\schanged=0\\s" Shift_Log/Shift.1/Ansible.log
result01=$?
grep -E "192\.168\.127\.41.*\\schanged=0\\s" Shift_Log/Shift.1/Ansible.log
result02=$?

diff Shift_Log/Shift.2/Serverspec_Result_192.168.127.31.csv Shift_Log/Serverspec_Result_192.168.127.31.csv
result03=$?
diff Shift_Log/Shift.2/Serverspec_Result_192.168.127.41.csv Shift_Log/Serverspec_Result_192.168.127.41.csv
result04=$?

exit $((result01 || result02 || result03 || result04))

