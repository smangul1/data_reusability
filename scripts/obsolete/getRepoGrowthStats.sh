#!/bin/bash

infile=$1
outfile=$2

# get all the dates
awk -F ',' '{print $5}' $infile | sed 1d | sort | uniq > dates

for i in NCBI_SRA EMBL DDBJ NCBI_GEO
do
	echo OG_${i} > OG_${i}
	echo RE_${i} > RE_${i}
done

while read date
do
	for i in NCBI_SRA EMBL DDBJ NCBI_GEO
	do
		grep ,OG $infile | grep -E ",${date}" | grep -E ",${i}," | wc -l >> OG_${i}
		grep ,RE $infile | grep -E ",${date}" | grep -E ",${i}," | wc -l >> RE_${i}
	done
done < dates

echo date > dateCol
cat dates >> dateCol

paste -d ',' dateCol OG_NCBI_SRA RE_NCBI_SRA OG_EMBL RE_EMBL OG_DDBJ RE_DDBJ OG_NCBI_GEO RE_NCBI_GEO > $outfile

