#! /bin/bash

shopt -s expand_aliases
alias improper='echo "usage: grepdir.sh directory pattern [-grep option]*"'

if [ $# -lt 2 ]
then
	improper
	exit
fi 


DIR_NAME=$1
PATTERN=$2
CD=pwd

if [ ! -e $DIR_NAME -o -f $DIR_NAME ]
then
	improper
	exit
fi

cd $DIR_NAME

shift
shift

OPTIONS=$@

while [ `expr index "$OPTIONS" -` -ne 0 ]
do
	OPTIONS="${OPTIONS/-/}"
	OPTIONS="${OPTIONS/ /}"
done

if [ `expr index $OPTIONS "l"` -ne 0 ]
then
	out="${DIR_NAME}/"
fi

out="$out"`grep -r"$OPTIONS" "$PATTERN"`
if [ `expr index "$OPTIONS" "l"` -ne 0 ]
then
	out="${out//
/
${DIR_NAME}/}"
fi

IFS='
'
for line in $out
do
	echo "${line#*:}"
done

