#!/bin/bash

indir=$1
outfile=$2
date=$(date +"%m-%d-%Y")

cd $indir

# Extract all the papers we care about from journalWanted
grep -o -r -E -H -e "[SDE]R[APXRSZ][0-9]{6,7}" -e "PRJNA[0-9]{6,7}" -e "G[DSP][SEL][0-9]{1,6}" -e "TCGA" -e "GTEx" $indir > ~/data_reusability/scripts/origData.txt

cd ~/data_reusability/scripts/

echo doi,repo_ID > doiAndRepoIDs.txt

# Make a column of PMC IDs
echo "PMC_ID,repo_ID" > pmcAndRepoIDs.txt
awk -F "[/.:]" '{print $7"."$8","$10}' origData.txt >> doiAndRepoIDs.txt

# Make a column of repository names
echo "repo_Name" > repoNames.txt
echo "journal_Name" > journalNames.txt

while read line; do
	echo BioRxiv >> journalNames.txt
	if [[ ! -z "$(echo $line | grep -o -E -e 'SR[APXRSZ]' -e 'PRJNA')" ]]
	then
		echo "NCBI_SRA" >> repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o -E 'ER[APXRSZ]')" ]]
	then
		echo "EMBL" >> repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o -E 'DR[APXRSZ]')" ]]
	then	
		echo "DDBJ" >> repoNames.txt	
	elif [[ ! -z "$(echo $line | grep -o -E 'G[DSP][SEL][0-9]{1,6}')" ]]
	then
		echo "NCBI_GEO" >> repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o 'TCGA')" ]]
	then
		echo "TCGA" >> repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o 'GTEx')" ]]
	then
		echo "GTEx" >> repoNames.txt 
	else
		echo "other" >> repoNames.txt
	fi
done < origData.txt

# Make a column of journal names

paste -d "," journalNames.txt doiAndRepoIDs.txt repoNames.txt > $outfile

mkdir zzbiorxivScript_dump_$date
mv doiAndRepoIDs.txt repoNames.txt journalNames.txt origData.txt zzbiorxivScript_dump_$date
