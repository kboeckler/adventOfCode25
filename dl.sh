#!/bin/bash
if [ -z "$1" ]; then
	echo "No day provided as first parameter."
	exit 1;
fi
SESSION_ID=
if [ -f ".session_id" ]; then
	SESSION_ID=$(cat .session_id)
else
	echo ".session_id file is missing. Aborting."
	exit 2
fi;
YEAR=2025
DAY=$1

curl -H "Cookie: session=$SESSION_ID" https://adventofcode.com/$YEAR/day/$DAY/input > .input/$DAY.txt

