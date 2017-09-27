#!/bin/sh -x

cd ${WORKSPACE}/shift

# Serverspecの結果判定
echo 1
grep -E "OK=0," Shift_Log/Serverspec_Result_192.168.127.141.csv
result01=$?

echo 2
grep -E "OK=0," Shift_Log/Serverspec_Result_192.168.127.151.csv
result02=$?


exit $((result01 || result02 ))

