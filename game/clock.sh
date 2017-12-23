#!/bin/bash
clear

rm -r .tmp/time
mkdir .tmp/time
# wait for start signal
while [ ! -e .tmp/time/start ] ; do
	echo "******* waiting to start *********"
	sleep 1
done
# countdown
total_time=$(cat .tmp/time/start)
while [ $total_time -gt 0 ] ; do
	echo "You have $total_time seconds left."
	total_time=$((total_time-1))
	sleep 1
	if [ -e .tmp/time/bonus ] ; then
		extra_time=$(cat .tmp/time/bonus)
		rm .tmp/time/bonus
		total_time=$((total_time+extra_time))
	fi
done
#

echo "YOU LOOOOOOOOOOOOOOOOOOOOOOOOSE"
