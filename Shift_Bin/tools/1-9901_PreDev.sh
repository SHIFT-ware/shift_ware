#!/bin/sh

#------------------------
# Set Val
#-------------------------
CODE="1-9901_PreDev"
SITE="tools/$CODE/main.yml"

INVENTORY_PATH="../Shift_Env/tools"
INVENTORY_FILES="^$CODE.*\.inventory$"

WORK_DIR="Ansible/"
cd $WORK_DIR
# load ansible.cfg from WORK_DIR/ansible.cfg

LOG_PATH="../Shift_Log/"
LOG_FILE="../Shift_Log/$CODE.log"

LOG_BKUP_GEN=9

case $1 in
  run) 
    MODE="run";;
  test) 
    MODE="dry-run"
    OPTION="-C";;
  debug) 
    MODE="debug"
    OPTION="-vvvvv";;
  *) 
    echo "sorry,please specify option. mode { run | test | debug }"
    echo "for example)"
    echo "    $0 run"
    echo "    $0 test"
    echo "    $0 debug"
    exit 1;;
esac

#-------------------------
# each func
#-------------------------
func_play() {
  f_rt=0
  for file in `ls $INVENTORY_PATH |grep $INVENTORY_FILES`;do
    if [ -e $HOME/.ssh/id_rsa_shift ] ; then
      ansible-playbook $SITE -i $INVENTORY_PATH/${file} -c paramiko --private-key="$HOME/.ssh/id_rsa_shift" $OPTION
    else
      ansible-playbook $SITE -i $INVENTORY_PATH/${file} -c paramiko $OPTION
    fi
    if [ $? -ne 0 ] ; then
      f_rt=1
    fi
  done
  return $f_rt
}

func_exec(){
  `$1`
  if [ $? -ne 0 ] ; then
    exit 1
  fi
}

func_logrotate(){
  if [ -d ${LOG_PATH}Shift.${LOG_BKUP_GEN} ] ; then
    func_exec "rm -rf ${LOG_PATH}Shift.${LOG_BKUP_GEN}"
  fi

  for i in `seq $(($LOG_BKUP_GEN - 1)) -1 1`
  do
    if [ -d ${LOG_PATH}Shift.${i} ] ; then
      func_exec "mv ${LOG_PATH}Shift.${i} ${LOG_PATH}Shift.$(($i + 1))"
    fi
  done

  for log in `ls -1 $LOG_PATH | grep -v Shift.*`
  do
    if ! [ -d ${LOG_PATH}Shift.1 ] ; then
      func_exec "mkdir ${LOG_PATH}Shift.1"
    fi
    func_exec "mv ${LOG_PATH}${log} ${LOG_PATH}Shift.1"
  done
}

func_logprint(){
  echo "`date "+%Y/%m/%d %H:%M:%S"`  [ $CODE $MODE ] $1"
}

#-------------------------
# Main
#-------------------------
if ! ls $INVENTORY_PATH|grep $INVENTORY_FILES > /dev/null 2>&1
then
  echo "[error] no inventory file(s)"
  exit 1
fi

func_logrotate

echo "`basename $0` $1 is doing..."
{
  echo "-----------------------------------------------------"
  func_logprint "start"

  func_play
  RT=$? 

  if [ "$RT" -ne 0 ] ; then
     func_logprint "error: Ansible return code is $RT"
  fi
  
  func_logprint "end"
  echo "-----------------------------------------------------"

} 2>&1 | tee $LOG_FILE

exit $RT
