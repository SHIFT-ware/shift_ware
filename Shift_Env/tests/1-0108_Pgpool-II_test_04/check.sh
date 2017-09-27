#!/bin/sh

cd ${WORKSPACE}/shift

echo "----RHEL6の実行結果----"
diff Shift_Log/Serverspec_Result_192.168.127.31.csv Shift_Log/Shift.2/Serverspec_Result_192.168.127.31.csv
result01=$?

echo "----RHEL7の実装はありません...----"
result02=$?

exit $((result01 || result02))

