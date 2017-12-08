#!/bin/bash
PROBCOMMAND=probcli


if [ $# -lt 5 ] 
then	
	echo "Usage ./parB2 <Nr. of workers> <minimum que size> <max number of states> <Port (usually 5000)> <filename for statistics> <file>"
	exit -1
else 
	echo "Running ProB in Parallel (on .prob files)"	
	# dirname
	if [ -h "$0" ]
	then
	    realname=`readlink "$0"`
	    dirname=`dirname "$realname"`
	else
	    dirname=`dirname "$0"`
	fi
	
	ulimit -d unlimited
	
	echo "Directory: $dirname"

# dirname
if [ -h "$0" ]
then
    realname=`readlink "$0"`
    dirname=`dirname "$realname"`
else
    dirname=`dirname "$0"`
fi

ulimit -d unlimited

# setting the library path to find the zmq shared libraries
system=`uname`
if [ $system = "Linux" ]; then
  export LD_LIBRARY_PATH="$dirname/lib"
fi

echo "Directory: $dirname"
#cd $dirname
#ls
echo "Starting workers in parallel"
for ((  i = 0 ;  i < $1;  i++  ))
do
  "$dirname/$PROBCOMMAND" -bf -zmq_worker2 localhost $4 0 $5-worker-$i &
done
echo "Starting proxy server: $dirname/extensions/zmq/proxy/proxy localhost $4 localhost $2 $5-proxy "
"$dirname/extensions/zmq/proxy/proxy" localhost $4 localhost $2 $5-proxy  &

echo "Starting master: $dirname/$PROBCOMMAND -bf -zmq_master2 " $2 $3 $4 0 localhost $5 $6
time "$dirname/$PROBCOMMAND" -bf -zmq_master2 $2 $3 $4 0 localhost $5 $6
fi
