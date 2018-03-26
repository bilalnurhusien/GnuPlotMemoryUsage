#!/bin/bash

if [ $# -lt 1 ]
then
	echo "Please pass ip addr for remote host to monitor"
	echo "Usage ./memorymon.sh XXX.XXX.XXX.XXX"
	exit
fi

export ip_addr=${1}
export free_mon_file=freemon.sh
export tmp_free_mon_path=/tmp/${free_mon_file}
export tmp_memory_data_path=/tmp/memoryusage.dat

#copy script to remote host
scp ${free_mon_file} "root@${ip_addr}:/tmp/"

#kill previously running task and launch new one on remote host
ssh "root@${ip_addr}" "pkill ${free_mon_file}; ${tmp_free_mon_path} &"

# wait for script to launch
sleep 5

while (true) do

	#copy memory usage data
	scp "root@${ip_addr}:${tmp_memory_data_path}" ${tmp_memory_data_path}

	#run gnuplot
	gnuplot -e "file_name='${tmp_memory_data_path}'" plot.in

	#exit gnuplot window
	pkill gnuplot

done


