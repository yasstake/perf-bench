#!/bin/bash
export LANG=C

UNIX_BENCH=/tmp/UnixBench/Run
DATE=`date +"%Y-%m-%d-%H%M%S"`

RESULT_DIR=/tmp/$DATE
TEST_FS_DIR=/tmp


if [ $# -ne 1 ]; then
    echo "please specfy test module"
    exit 1
fi

# start SAR log
echo "start logging to" $RESULT_DIR
mkdir $RESULT_DIR

SARFILE=$RESULT_DIR/sar.log
sar -A -o $SARFILE  1 > /dev/null &
SAR_PID=$!

function stop_sar {
    kill -9 $SAR_PID

}
trap stop_sar EXIT


#----- test execution ----

case $1 in
    'unixbench')
	echo "unix bench"
	export UB_TMPDIR=$TEST_FS_DIR
	export UB_RESULTDIR=$RESULT_DIR

	$UNIX_BENCH fsbuffer-w
	#$UNIX_BENCH
	;;
esac



#---- archive log --
    
sadf -T -- -A $SARFILE > $RESULT_DIR/sar.csv
zip -r $RESULT_DIR.zip $RESULT_DIR


