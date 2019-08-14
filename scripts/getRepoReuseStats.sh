#!/bin/bash

infile=$1
outfile=$2

echo ID > ids
echo reuseCount > reuseCounts

while read id
do
	echo ${id} >> ids
	grep -E ",${id}," $infile | sed 1d | wc -l >> reuseCounts

done < uniqueRepoIDs.txt

paste -d ',' ids reuseCounts > $outfile
