#!/bin/sh -x

cd ${WORKSPACE}/shift

# Serverspecの結果判定
echo 01
grep -E "NG=0," Shift_Log/Shift.1/Serverspec_Result_192.168.127.31.csv
result01=$?

echo 02
grep -E "NG=0," Shift_Log/Shift.1/Serverspec_Result_192.168.127.41.csv
result02=$?

# Serverspecの結果判定
echo 03
grep -E "OK=0," Shift_Log/Serverspec_Result_192.168.127.31.csv
result03=$?

echo 04
grep -E "OK=0," Shift_Log/Serverspec_Result_192.168.127.41.csv
result04=$?


exit $((result01 || result02 || result03 || result04 ))


