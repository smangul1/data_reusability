#!/bin/bash

indir=$1
outfile=$2

cd $indir

grep -o -r -E -H -e "[A-Z]{2}_[0-9]{5,6}" -e "[A-Z]{2}[0-9]{5,6}" $indir > ~/data_reusability/genBankBigNet.txt

cd ~/data_reusability/

while read line
do
	file=$(echo $line | awk -F ':' '{print $1}')
	if [[ ! -z "$(grep GenBank $file)" ]]
	then
		echo $line >> genBankConfirmed.txt
	fi
done < genBankBigNet.txt
