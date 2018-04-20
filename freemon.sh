#!/bin/sh

max_file_length=2000
trim_length=100

while true; do 
{
	file_size=`cat /tmp/memoryusage.dat | wc -l`
	if [ $file_size -gt $max_file_length ]
		then
			sed -e '1,${trim_length}d' < /tmp/memoryusage.dat > /tmp/tmp_memoryusage.dat
			mv /tmp/tmp_memoryusage.dat /tmp/memoryusage.dat
	fi

	free -k | awk -v timestamp=$(date +"%H:%M") 'NR==2{print timestamp,$2,$3,$4,$5}' >> /tmp/memoryusage.dat; sleep 60;
}
done 
