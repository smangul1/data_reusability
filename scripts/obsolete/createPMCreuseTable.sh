#!/bin/bash

infile=$1
outfile=$2

echo repoIDcount > counts

while read line
do
	grep -E ",$line," $infile | wc -l >> counts
done < pmcsReusing.txt

echo pmc > pmc
cat pmcsReusing.txt >> pmc

paste -d ',' pmc counts > $outfile
