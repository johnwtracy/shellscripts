#! /bin/bash

if [ "$#" -lt 1 ]
then
	echo  "usage: uncomp.sh {filelist}+"
fi

for file in $@
do
	case $file in 
	*.tar.gz)
	tar -xvf $file ;;
	*.tar)
	tar -xf $file ;;
	*.tgz)
	tar -zxvf $file ;;
	*.gz)
	gzip -d $file ;;
	*.zip)
	unzip $file ;;
	*)
	echo $file has no compression extension ;;

done

