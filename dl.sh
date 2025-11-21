#!/bin/bash
YEAR=2025
DAY=0
if [ ! -z "$1" ]; then
	DAY=$1
else
	echo "No day provided as first parameter."
	exit 1
fi
if [ ! -z "$2" ]; then
	YEAR=$2
fi

SESSION_ID=
if [ -f ".session_id" ]; then
	SESSION_ID=$(cat .session_id)
else
	echo ".session_id file is missing. Aborting."
	exit 2
fi;

mkdir -p .input/$YEAR
curl -H "Cookie: session=$SESSION_ID" https://adventofcode.com/$YEAR/day/$DAY/input > .input/$YEAR/$DAY.txt

