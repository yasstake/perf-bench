#!/bin/bash
export LANG=C


DATE=`date +"%Y-%m-%d-%H%M%S"`

RESULT_DIR=/tmp/$DATE
TEST_FS_DIR=/tmp


if [ $# -ne 1 ]; then
    echo "please specfy test module"
    echo "[unixbench | dbench | vdbench | iperf | pgbench]"
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
#	sleep 10
	UNIX_BENCH_DIR=/tmp/UnixBench/	
	export UB_TMPDIR=$TEST_FS_DIR
	export UB_RESULTDIR=$RESULT_DIR

	cd $UNIX_BENCH_DIR
	./Run fsbuffer-w
#	sleep 10	
	;;

    'dbench')
	#sleep 10

	# do test
	
	#sleep 10
	;;

    'vdbench')
	#sleep 10

	# do test
	
	#sleep 10
	;;

    'iperf')
	#sleep 10

	# do test
	
	#sleep 10
	;;

    'pgbench')
	#sleep 10

	# do test
	
	#sleep 10
	;;
esac


#---- archive log --
    
sadf -T -- -A $SARFILE > $RESULT_DIR/sar.csv
zip -r $RESULT_DIR.zip $RESULT_DIR


