#!/bin/bash

date=$(date +"%m-%d-%Y")

outfile=$1

# set up files to dump counts in
for r in MULTI NCBI_SRA EMBL DDBJ NCBI_GEO TCGA GTEx
do
	echo $r > $r
done

###
# for each journal, count the number of papers mentioning each repository
###

while read j
do
	# extract all the papers in this journal
	grep -E "^${j}," uniq_pmcMatrix_noRepoName.csv | awk -F ',' '{print $2}' > thisJournal.txt
	# check how many hits come up for each paper in the list of only papers and repo names
	echo count_of_repos > countMe
	while read line
	do
		if [ $(grep $line uniq_pmcMatrix_noRepoID.csv | wc -l) -gt 1 ]
		then
			echo MULTI >> countMe
		else # it'll match just one time
			grep $line uniq_pmcMatrix_noRepoID.csv | awk -F ',' '{print $3}' >> countMe
		fi
	done < ~/data_reusability/thisJournal.txt
	# drop the count numbers in their respective files
	for r in MULTI NCBI_SRA EMBL DDBJ NCBI_GEO TCGA GTEx
	do
		grep $r countMe | wc -l >> ${r}
	done
done < allJournalNames.txt
###

echo journalName > journalNames
cat allJournalNames.txt >> journalNames
paste -d ',' journalNames MULTI NCBI_SRA EMBL DDBJ NCBI_GEO TCGA GTEx > $outfile

mkdir stats_dump_$date

mv allJournalNames.txt journalNames MULTI NCBI_SRA EMBL DDBJ NCBI_GEO TCGA GTEx thisJournal.txt countMe stats_dump_$date
