#!/bin/bash

infile=$1
outfile=$2

echo journalName > journals
echo orig > OG
echo reuse > RE

while read j
do
	echo $j >> journals
	grep -E "^${j}," $infile | grep ,OG | wc -l >> OG
	grep -E "^${j}," $infile | grep ,RE | wc -l >> RE
done < OGjournalNames.txt

paste -d ',' journals OG RE > $outfile
