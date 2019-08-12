#!/bin/bash

infile=$1
outfile=$2

echo journalName > journals
echo origSRA > OGsra
echo reuseSRA > REsra
echo origGEO > OGgeo
echo reuseGEO > REgeo

while read j
do
	echo $j >> journals
	grep -E "^${j}," $infile | grep -E -e "NCBI_SRA,[0-9]{4},OG" -e "DDBJ,[0-9]{4},OG" -e "EMBL,[0-9]{4},OG" | wc -l >> OGsra
	grep -E "^${j}," $infile | grep -E "NCBI_GEO,[0-9]{4},OG" | wc -l >> OGgeo
	grep -E "^${j}," $infile | grep -E -e "NCBI_SRA,[0-9]{4},RE" -e "DDBJ,[0-9]{4},RE" -e "EMBL,[0-9]{4},RE" | wc -l >> REsra
	grep -E "^${j}," $infile | grep -E "NCBI_GEO,[0-9]{4},RE" | wc -l >> REgeo
done < OGjournalNames.txt

paste -d ',' journals OGsra REsra OGgeo REgeo > $outfile
