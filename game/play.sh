#!/bin/bash

usage(){ echo "Usage: $0 [-h show usage.] \
    [-s display number of answers and questions] \
    [-r reset current game: clear answer and question folder]" 1>&2; exit 1; }

while getopts ":h:s:r:" o; do
    case "${o}" in
        h)
            usage ;;
        s) 
            echo "Stats: "
            echo 
            echo "Number of participants: $(ls -A .tmp/names | wc -l)"
            for n in .tmp/names/* ; do
              echo $n
              ls $n
              ls $n/bonus
            done
            exit ;;
        r)
            echo "rm -r .tmp/names" 
            rm -r .tmp/names
            exit ;;
        *)
            usage ;;
    esac
done
shift $((OPTIND-1))



############################################################
read -p 'Is the clock thread running? [y/n] ' clk
if [[ ! -z $clk && $clk != 'y' ]] ; then
  exit
fi
# Configuration:
punishment=$((3*60))
time_to_play=$((60*60))
echo "time to play: $time_to_play"
echo $time_to_play > .tmp/time/start


############################################################
read -p 'Are you sure you want to start? [y/n] ' cont
if [[ ! -z $cont && $cont != 'y' ]] ; then
  exit
fi

############################################################
echo 
echo ---------------------------------------------------------------
echo "Welcome to Control-Escape Game!"
echo "You have $time_to_play seconds to end this game successfully."
echo "Goodluck!"
echo ---------------------------------------------------------------
echo 
sleep 1
echo 3
sleep 1
echo 2
sleep 1
echo 1
sleep 1
echo 0
id_list=$(echo .tmp/names/*)
for id in $id_list ; do
  clear
  name="$(cat $id/name)"
  echo "This level is brought to you by $name."
  echo "Would $name be so kind and remove him or herself from the others?"
  read -p "Is $name zoned out? " e
  echo "Here we go!"
  sleep 1
  clear
  if [ -e $id/bonus/q_1 ] ; then cp $id/bonus/q .tmp/bonus_1/; fi
  if [ -e $id/bonus/a_1 ] ; then cp $id/bonus/a .tmp/bonus_1/; fi
  if [ -e $id/bonus/q_2 ] ; then cp $id/bonus/q .tmp/bonus_2/; fi
  if [ -e $id/bonus/a_2 ] ; then cp $id/bonus/a .tmp/bonus_2/; fi
  echo
  cat $id/q
  echo
  while [ true ] ; do
    read ans
    if [ "$(cat $id/a)" != "$ans" ] ; then
      echo "wrong, you loose $punishment seconds." 
      echo "-$punishment" > .tmp/time/bonus
    else
       echo 'well done.'
       sleep 2
       break
    fi
  done
  touch .tmp/bonus/stop
done

echo "done"

