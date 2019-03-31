#!/bin/sh
if [ "$1" == "" ]; then
	echo "No Table Specified. Aborting"
	exit
fi
TABLE=$1
FILE="`pwd`/$TABLE.csv"
CWD="load data local infile '$FILE' into TABLE $TABLE FIELDS TERMINATED by '\t' IGNORE 1 LINES; SHOW WARNINGS"
mysql --user=root --password=root -e "$CWD" --verbose --force torontocatrescue
