#!/bin/bash

#Arguments check
if [ $# != 3 ]; then
	echo "Usage: ./rename_all.sh directory from to"
	exit 1
fi
if ! [ -d $1 ]; then
	echo "$1" is not a directory
	exit 2
fi

DIR="$1"
FROM="$2"
TO="$3"

cd "$DIR"

ls -l | grep "$FROM"

END=$(ls -l | tail +2 | grep "$FROM" | wc -l)

if [[ $END == 0 ]]; then
	echo There is no file that match with "$FROM"
	exit 3
fi

#Core of the script
for i in $(eval echo "{1..$END}"); do
	rename "s/$FROM$i/$TO$i/g" *
done

if [[ $(ls -l | tail +2 | grep "$TO" | wc -l) == 0 ]]; then
	echo Error in renaming
	exit 4
fi

echo Done

ls -l | grep "$TO"
