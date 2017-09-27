#!/bin/sh

cd ${WORKSPACE}/shift

echo "----RHEL6の実行結果----"
grep -e "NG=0" Shift_Log/Serverspec_Result_192.168.127.31.csv
result01=$?

echo "----RHEL7の実装はありません...----"
result02=$?

exit $((result01 || result02))

