#!/bin/sh

cd ${WORKSPACE}/shift

grep -e "changed=0" Shift_Log/Ansible.log
result01=$?

exit $result01

