#!/bin/bash

indir=$1
date=$(date +"%m-%d-%Y")

echo journalName > journalNames
echo totalPapers > totPapers
echo repoPapers > repoPapers

cd $indir

while read journal
do
	echo ${journal} >> ~/data_reusability/journalNames
	ls ${journal}/*.nxml | wc -l >> ~/data_reusability/totPapers
	grep -E "^${journal}," ~/data_reusability/uniq_pmcMatrix_noRepoName.csv | wc -l >> ~/data_reusability/repoPapers
done < ~/data_reusability/allJournalNames.txt

cd ~/data_reusability/

echo pctRepoPapers > pctRepo
paste totPapers repoPapers -d ',' | sed 1d | awk -F ',' '{print $2/$1*100}' >> pctRepo

paste journalNames totPapers repoPapers pctRepo -d ',' > repoPctStats.csv

mkdir zzpercent_repo_dump_$date
mv journalNames totPapers repoPapers pctRepo zzpercent_repo_dump_$date
