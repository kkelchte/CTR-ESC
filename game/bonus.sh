#!/bin/bash
if [ -z "$1" ] ; then
	num=1
else
	num=$1
fi
echo "bonus $num started."

punishment=$((60*1))
present=$((60*5))

rm -r .tmp/bonus
mkdir .tmp/bonus

while [ true ] ; do 
	# wait for bonus question
	while [ ! -e .tmp/bonus_$num/q ] ; do
		clear
		echo "******* waiting for bonus_$num *********"
		sleep 1
	done
	function bonus_received(){
		while [ true ] ; do
			read -p "$(cat .tmp/bonus_$num/q)" answer
			if [ "$(cat .tmp/bonus_$num/a)" != "$answer" ] ; then
				echo "wrong, you loose $punishment seconds." 
				echo "-$punishment" > .tmp/time/bonus_$num
		    else
				echo 'well done.'
				echo "$present" > .tmp/time/bonus_$num
				rm -r .tmp/bonus_$num/*
				break
		    fi
		done
	}
	bonus_received &
	pid=$! 
	while [ ! -e .tmp/bonus_$num/stop ] ; do
		sleep 1;
	done
	kill $pid
	rm -r .tmp/bonus_$num/*
done