#!/bin/sh

cd ${WORKSPACE}/shift

echo "----RHEL6の実行結果----"
grep -e "NG=1" Shift_Log/Serverspec_Result_192.168.127.31.csv
result01=$?
grep -e "OK=0" Shift_Log/Serverspec_Result_192.168.127.31.csv
result02=$?

echo "----RHEL7の実装はありません...----"
result03=$?

exit $((result01 || result02 || result03))

