#!/bin/bash

infile=$1
outfile=$2

echo journalName > journals
echo tags > tags
echo values > vals

for j in Bioinformatics BMC_Bioinformatics BMC_Genomics BMC_Syst_Biol Genome_Biol Genome_Med Nat_Biotechnol Nat_Methods Nucleic_Acids_Res PLoS_Comput_Biol
do
	echo $j >> journals
	echo $j >> journals
	echo OG >> tags
	grep -E "^${j}" $infile | grep ,OG | wc -l >> vals
	echo RE >> tags
	grep -E "^${j}" $infile | grep ,RE | wc -l >> vals
done

paste -d ',' journals tags vals > $outfile
