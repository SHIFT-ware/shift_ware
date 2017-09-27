#!/bin/sh

#------------------------
# Set Val
#-------------------------
CODE="Serverspec"

WORK_DIR="Serverspec/"
cd $WORK_DIR

INVENTORY_PATH="../Shift_Env/"
INVENTORY_FILES="^$CODE.*\.inventory$"

LOG_PATH="../Shift_Log/"
LOG_FILE="../Shift_Log/$CODE.log"

LOG_BKUP_GEN=9

case $1 in
  run) 
    MODE="run";;
  *) 
    echo "sorry,please specify option. mode { run }"
    echo "for example)"
    echo "    $0 run"
    exit 1;;
esac

#-------------------------
# each func
#-------------------------

# タスクのプロセス並列実行
func_play() {
  for file in `ls $INVENTORY_PATH |grep $INVENTORY_FILES`;do
    tasks=(`func_get_tasks "${file}"`) # タスクを配列として保存
    func_run_tasks ${tasks[@]}
  done
}

# 実行タスクの一覧取得
func_get_tasks() {
  cp $INVENTORY_PATH$1 ./Serverspec.inventory
  rake -T | sed -e "s/#.*//g" | sed -e "s/rake//1" # タスク一覧からtask名部分を切り出し出力
}

# タスクの実行及びエラーメッセージ出力
func_run_tasks() {
  local local_rt=0
  for task in $@
  do
    # タスクごとにバックグラウンド実行しwait $!で終了コード取得
    # エラーの場合はエラーメッセージを出力 
    ((rake ${task} & wait $! ) || (func_logprint "error: rake ${task} is returned error"; false))&
  done
  wait 
}

func_exec() {
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
  
  func_logprint "end"
  echo "-----------------------------------------------------"

} 2>&1 | tee $LOG_FILE

if [ -d ../Serverspec/log ] ; then
  cp -r ../Serverspec/log  ${LOG_PATH}Serverspec_Debug
  rm -rf ../Serverspec/log
fi
