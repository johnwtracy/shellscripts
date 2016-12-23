#! /bin/bash

shopt -s expand_aliases
alias error='echo "usage: cpdirs.sh source_directory1 source_directory2 dest_directory"'

if [ $# -ne 3 ]
then
	error
	exit
fi

if [ -d $1 -a -d $2 ]
then
	ls1=`ls "$1"`
	ls2=`ls "$2"`
else
 	error
	exit
fi

ls1=${ls1//
/ }
ls2=${ls2//
/ }

CD=`pwd`

if [ ! -d "$3" ]
then
	mkdir "$3"
fi

cd "$3"
thrd=`pwd`
cd "$CD"
cd "$1"

for file in $ls1
do
if [ -f $file ]
	then
		ls12="$ls12 $file"
	fi
done

for file in $ls2
do
	if [ -f $file ]
	then
		ls22="$ls22 $file"
	fi
done

if [ -n "$ls22" ]
then
	`cp${ls22} $thrd`
fi

cd "$CD"
cd "$2"

new=""

for file in $ls12
do
	if [ -e $file ]
	then
		
	fi
done

if [ -n "$ls12" ]
then
	`cp${ls12} $thrd`
fi

















