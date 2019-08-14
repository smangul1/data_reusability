#!/bin/bash

indir=$1
outfile=$2
date=$(date +"%m-%d-%Y")

cd $indir

# Extract all the papers we care about from journalWanted
grep -o -r -E -H -e "[SDE]R[APXRSZ][0-9]{6,7}" -e "PRJNA[0-9]{6,7}" -e "G[DSP][SEL][0-9]{1,6}" -e "TCGA" -e "GTEx" $indir > ~/data_reusability/origData.txt

# Make a column of PMC IDs
echo "PMC_ID,repo_ID" > ~/data_reusability/pmcAndRepoIDs.txt
awk -F "[/.:]" '{print $8","$10}' ~/data_reusability/origData.txt >> ~/data_reusability/pmcAndRepoIDs.txt

# Make a column of repository names
echo "repo_Name" > ~/data_reusability/repoNames.txt

while read line; do
	if [[ ! -z "$(echo $line | grep -o -E -e 'SR[APXRSZ]' -e 'PRJNA')" ]]
	then
		echo "NCBI_SRA" >> ~/data_reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o -E 'ER[APXRSZ]')" ]]
	then
		echo "EMBL" >> ~/data_reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o -E 'DR[APXRSZ]')" ]]
	then	
		echo "DDBJ" >> ~/data_reusability/repoNames.txt	
	elif [[ ! -z "$(echo $line | grep -o -E 'G[DSP][SEL][0-9]{1,6}')" ]]
	then
		echo "NCBI_GEO" >> ~/data_reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o 'TCGA')" ]]
	then
		echo "TCGA" >> ~/data_reusability/repoNames.txt
	elif [[ ! -z "$(echo $line | grep -o 'GTEx')" ]]
	then
		echo "GTEx" >> ~/data_reusability/repoNames.txt 
	else
		echo "other" >> ~/data_reusability/repoNames.txt
	fi
done < ~/data_reusability/origData.txt

# Make a column of journal names

echo "journal_Name" > ~/data_reusability/journalNames.txt

awk -F "/" '{print $7}' ~/data_reusability/origData.txt >> ~/data_reusability/journalNames.txt

cd ~/data_reusability/

paste -d "," journalNames.txt pmcAndRepoIDs.txt repoNames.txt > mostOfIt.csv

# Add the dates column
sed 1d mostOfIt.csv | awk -F ',' '{print "/u/scratch/n/nikodm/pmcOA/"$1"/"$2".nxml"}' > filepaths.txt

. /u/local/Modules/default/init/modules.sh
module load python/3.7.2

echo date > ~/data_reusability/dates.txt

python3 ~/data_reusability/extractDate.py filepaths.txt >> ~/data_reusability/dates.txt

paste -d "," mostOfIt.csv dates.txt > $outfile

mkdir zzmatrixScript_dump_$date
mv pmcAndRepoIDs.txt repoNames.txt journalNames.txt origData.txt mostOfIt.csv dates.txt filepaths.txt zzmatrixScript_dump_$date
