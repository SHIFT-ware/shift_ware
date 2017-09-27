#!/bin/sh -x

cd ${WORKSPACE}/shift

# Serverspec
echo 01
grep -E "OK=2," Shift_Log/Shift.4/Serverspec_Result_192.168.127.141.csv
result01=$?

echo 02
grep -E "OK=2," Shift_Log/Shift.4/Serverspec_Result_192.168.127.151.csv
result02=$?


# Ansibleの結果判定
echo 03
grep -E "192\.168\.127\.141\s*:\s*ok=[0-9]{1,3}\s*changed=[0-9]{1,3}\s*unreachable=0\s*failed=0" Shift_Log/Shift.3/Ansible.log
result03=$?

echo 04
grep -E "192\.168\.127\.151\s*:\s*ok=[0-9]{1,3}\s*changed=[0-9]{1,3}\s*unreachable=0\s*failed=0" Shift_Log/Shift.3/Ansible.log
result04=$?


# Serverspecの結果判定
echo 05
grep -E "NG=0," Shift_Log/Shift.2/Serverspec_Result_192.168.127.141.csv
result05=$?

echo 06
grep -E "NG=0," Shift_Log/Shift.2/Serverspec_Result_192.168.127.151.csv
result06=$?

# Ansibleの結果判定
echo 07
grep -E "192\.168\.127\.141\s*:\s*ok=[0-9]{1,3}\s*changed=0\s*unreachable=0\s*failed=0" Shift_Log/Shift.1/Ansible.log
result07=$?

echo 08
grep -E "192\.168\.127\.151\s*:\s*ok=[0-9]{1,3}\s*changed=0\s*unreachable=0\s*failed=0" Shift_Log/Shift.1/Ansible.log
result08=$?

# Serverspecの結果判定
echo 9
grep -E "NG=0," Shift_Log/Serverspec_Result_192.168.127.141.csv
result09=$?

echo 10
grep -E "NG=0," Shift_Log/Serverspec_Result_192.168.127.151.csv
result10=$?


exit $((result01 || result02 || result03 || result04 || result05 || result06 || result07 || result08 || result09 || result10 ))

