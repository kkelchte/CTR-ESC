#!/bin/bash
while getopts ":s:" o; do
    case "${o}" in
        s)
            echo "print all stats:"
            for n in .tmp/names/* ; do
            	echo "$(basename n):"
            	ls $n

	        done
            exit ;;
        *)
            usage ;;
    esac
done
shift $((OPTIND-1))

clear
echo "This is the input service for preparing a CTR-ESC game."

read -p "Type your name and press enter: " name

id=echo $(( RANDOM % 999))
mkdir -p .tmp/names/$id
cat $name > .tmp/names/$id/name

bonus=false
while [ true ] ; do
	read -p "Is this a normal or a bonus question? type n or b and press enter: " b_answer
	if [ $b_answer = 'n' ] ; then 
		bonus=false
		break;
	fi
	if [ $b_answer = 'b' ] ; then 
		bonus=true
		mkdir -p .tmp/names/$id/bonus
		num=$(ls -A .tmp/names/$id/bonus | wc -l)
		num=$((num+1))
		break;
	fi 
done
echo "bonus: $bonus"
while [ "1" = "1" ] ; do
	echo
	echo "Please fill in your question and press enter to submit. (please don't use enters in you question, it will make me jump to my next question)"
	# echo "Please fill in your question in the opening window:"
	# adjust with GEDIT
	read question
	echo
	echo
	echo "Please fill in the correct answer. Note that the answer is capital sensitive and please don't use any special characters like é or Æ."
	# adjust with GEDIT
	read answer
	echo
	echo "So this is what we got:"
	echo "-----------------------"
	echo "question:"
	echo $question
	echo "-----------------------"
	echo "answer:"
	echo $answer
	echo "-----------------------"
	echo 
	happy=""
	read -p "Are you happy? (respond with no if you want to resubmit)." happy
	if [[ -z $happy || $happy != "no" ]] ; then
	break;
	fi
done
mkdir -p .tmp/names/$id
if [ $bonus = true ] ; then
	mkdir -p .tmp/names/$id/bonus
	echo $question >> .tmp/names/$id/bonus/q_$num
	echo $answer >> .tmp/names/$id/bonus/a_$num
else
	echo $question >> .tmp/names/$id/q
	echo $answer >> .tmp/names/$id/a
fi
echo "Thanks a bunch!"

