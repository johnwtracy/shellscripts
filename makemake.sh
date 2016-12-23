#! /bin/bash

shopt -s expand_aliases
alias improper='echo "Executable name required."
echo "usage: makemake.sh executable_name"'

if [ "$#" -lt 1 ]
then
	improper
	exit
fi

CPP=`ls *.cpp`
if [ -z "$CPP" ]
then
	exit
fi

for word in $CPP
do
	O="$O ${word/.cpp/.o}"
done

printf "%s" "$1 :" > Makefile

printf "%s\n" "$O  " >> Makefile

EXEC="$1"
shift
OPTIONS="$@"

if [ -n "$OPTIONS" ]
then
	printf "%s" "	g++ -ansi -Wall -g -o $EXEC ${OPTIONS}$O  " >> Makefile
else
	printf "%s" "	g++ -ansi -Wall -g -o ${EXEC}$O  " >> Makefile
fi

printf "\n\n" >> Makefile

for fileName in $O
do
	printf "%s" "$fileName : ${fileName/.o/.cpp}" >> Makefile
	greped=`grep "#include \"" ${fileName/.o/.cpp}`
	
	if [ -n "$greped" ]
	then

		for line in $greped
		do
			greped=${greped/"#include \""/}
			greped=${greped%\"}
		done
	fi
	
	GREP=""
	for word in $greped
	do
		GREP="$GREP ${word/\"/}"
	done

	printf "%s" "$GREP " >> Makefile
	
	if [ -n "$OPTIONS" ]
	then
		printf "\n%s" "	g++ -ansi -Wall -g -c $OPTIONS ${fileName/.o/.cpp}" >> Makefile
	else
		printf "\n%s" "	g++ -ansi -Wall -g -c ${fileName/.o/.cpp}" >> Makefile
	fi

	echo "" >> Makefile
	echo "" >> Makefile
done

O=${O// /  }
O=${O# }
printf "%s\n\t%s\n" "clean : " "rm -f ${EXEC}$O   " >> Makefile




















