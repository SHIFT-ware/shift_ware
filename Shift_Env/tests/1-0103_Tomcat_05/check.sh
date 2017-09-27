#!/bin/sh

cd ${WORKSPACE}/shift

grep -e "192.168.127.31" Shift_Log/Shift.1/Ansible.log | grep -e "changed=0"
result01=$?
diff Shift_Log/Shift.2/Serverspec_Result_192.168.127.31.csv Shift_Log/Serverspec_Result_192.168.127.31.csv
result02=$?

sum=`expr $result01 + $result02`

exit $sum
