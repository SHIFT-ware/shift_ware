#!/bin/sh

cd ${WORKSPACE}/shift

# Serverspecの結果判定
grep -E "NG=0," Shift_Log/Serverspec_Result_192.168.127.31.csv
result01=$?
grep -E "NG=0," Shift_Log/Serverspec_Result_192.168.127.41.csv
result02=$?

exit $((result01 || result02))
