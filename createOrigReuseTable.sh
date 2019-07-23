#!/bin/bash

# This script uses the publish date to determine which papers are generating and reusing their data

infile=$1
outfile=$2

echo "journalName,PMC_ID,repoID,repoName,date,isOG" > $outfile

while read id
do
	grep -E ",${id}," $infile | sort -t ',' -k 5 > sortedByDate 
	head -1 sortedByDate | sed -e 's/$/,OG/' >> $outfile
	sed 1d sortedByDate | sed -e 's/$/,RE/' >> $outfile	

done < ~/data_reusability/uniqueRepoIDs.txt
