#!/bin/bash

indir=$1
outfile=$2
date=$(date +"%m-%d-%Y")

cd $indir

# Extract all the papers we care about from journalWanted
grep -o -r -E -H -e "[SDE]R[APXRSZ][0-9]{6,7}" -e "PRJNA[0-9]{6,7}" -e "G[DSP][SEL][0-9]{1,6}" -e "TCGA" -e "GTEx" $indir > ~/data-reusability/origData.txt

# Make a column of PMC IDs
echo "PMC_ID,repo_ID" > ~/data-reusability/pmcAndRepoIDs.txt
awk -F "[/.:]" '{print $9","$11}' ~/data-reusability/origData.txt >> ~/data-reusability/pmcAndRepoIDs.txt

# Make a column of repository names
echo "repo_Name" > ~/data-reusability/repoNames.txt

while read line; do
	if [[ ! -z "$(echo $line | grep -o -E -e 'SR[APXRSZ]' -e 'PRJNA')" ]]
	then
		echo "NCBI_SRA" >> ~/data-reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o -E 'ER[APXRSZ]')" ]]
	then
		echo "EMBL" >> ~/data-reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o -E 'DR[APXRSZ]')" ]]
	then	
		echo "DDBJ" >> ~/data-reusability/repoNames.txt	
	elif [[ ! -z "$(echo $line | grep -o -E 'G[DSP][SEL][0-9]{1,6}')" ]]
	then
		echo "NCBI_GEO" >> ~/data-reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o 'TCGA')" ]]
	then
		echo "TCGA" >> ~/data-reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o 'GTEx')" ]]
	then
		echo "GTEx" >> ~/data-reusability/repoNames.txt 
	else
		echo "other" >> ~/data-reusability/repoNames.txt
	fi
done < ~/data-reusability/origData.txt

# Make a column of journal names

echo "journal_Name" > ~/data-reusability/journalNames.txt

awk -F "/" '{print $8}' ~/data-reusability/origData.txt >> ~/data-reusability/journalNames.txt

cd ~/data-reusability/

paste -d "," journalNames.txt pmcAndRepoIDs.txt repoNames.txt > mostOfIt.csv

# Add the dates column
sed 1d mostOfIt.csv | awk -F ',' '{print "/u/scratch/d/datduong/pubmedArticle4Dec17/journalWanted/"$1"/"$2".nxml"}' > filepaths.txt

module load python/3.7.2

echo date > ~/data-reusability/dates.txt

python3 ~/data-reusability/extractDate.py filepaths.txt >> ~/data-reusability/dates.txt

paste -d "," mostOfIt.csv dates.txt > $outfile

mkdir zzmatrixScript_dump_$date
mv pmcAndRepoIDs.txt repoNames.txt journalNames.txt origData.txt mostOfIt.csv dates.txt filepaths.txt zzmatrixScript_dump_$date
