#!/bin/sh

cd ${WORKSPACE}/shift

# Serverspecの結果判定
diff Shift_Log/Shift.2/Serverspec_Result_192.168.127.31.csv Shift_Log/Serverspec_Result_192.168.127.31.csv
result01=$?

exit $result01
