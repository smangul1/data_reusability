#!/bin/bash

date=$(date +"%m-%d-%Y")

outfile=$1

echo x > repos.txt
for r in MULTI NCBI_SRA EMBL DDBJ NCBI_GEO TCGA GTEx
do
	echo $r >> repos.txt
done

###
# for each journal:
###

for j in Bioinformatics BMC_Bioinformatics BMC_Genomics BMC_Syst_Biol Genome_Biol Genome_Med Nat_Biotechnol Nat_Methods Nucleic_Acids_Res PLoS_Comput_Biol
do
	grep -E "^${j}" uniq_pmcMatrix_noRepoName.csv | awk -F ',' '{print $2}' > ${j}PMC.txt

	echo count_of_repos > countMe
	while read line
	do
		if [ $(grep $line uniq_pmcMatrix_noRepoID.csv | wc -l) -gt 1 ]
		then
			echo MULTI >> countMe
		else # it'll match just one time
			grep $line uniq_pmcMatrix_noRepoID.csv | awk -F ',' '{print $3}' >> countMe
		fi
	done < ~/data_reusability/${j}PMC.txt

	echo ${j} > ${j}
	for r in MULTI NCBI_SRA EMBL DDBJ NCBI_GEO TCGA GTEx
	do
		grep $r countMe | wc -l >> ${j}
	done
done
###

paste repos.txt Bioinformatics BMC_Bioinformatics BMC_Genomics BMC_Syst_Biol Genome_Biol Genome_Med Nat_Biotechnol Nat_Methods Nucleic_Acids_Res PLoS_Comput_Biol -d ',' > $outfile

mkdir stats_dump_$date
mv repos.txt Bioinformatics* BMC_Bioinformatics* BMC_Genomics* BMC_Syst_Biol* Genome_Biol* Genome_Med* Nat_Biotechnol* Nat_Methods* Nucleic_Acids_Res* PLoS_Comput_Biol* stats_dump_$date 
