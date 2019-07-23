#!/bin/bash

date=$(date +"%m-%d-%Y")

echo journalName > journalNames
echo totalPapers > totPapers
echo repoPapers > repoPapers

cd /u/scratch/d/datduong/pubmedArticle4Dec17/journalWanted/

for i in 'Bioinformatics' 'BMC_Bioinformatics' 'BMC_Genomics' 'BMC_Syst_Biol' 'Genome_Biol' 'Genome_Med' 'Nat_Biotechnol' 'Nat_Methods' 'Nucleic_Acids_Res' 'PLoS_Comput_Biol'
do
	echo $i >> ~/data-reusability/journalNames
	ls $i/*.nxml | wc -l >> ~/data-reusability/totPapers
	grep -E "^${i}" ~/data-reusability/uniq_pmcMatrix_noRepoName.csv | wc -l >> ~/data-reusability/repoPapers
done

cd ~/data-reusability/

echo pctRepoPapers > pctRepo
paste totPapers repoPapers -d ',' | sed 1d | awk -F ',' '{print $2/$1*100}' >> pctRepo

paste journalNames totPapers repoPapers pctRepo -d ',' > repoPctStats.csv

mkdir zzpercent_repo_dump_$date
mv journalNames totPapers repoPapers pctRepo zzpercent_repo_dump_$date
