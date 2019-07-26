#!/bin/bash

infile=$1
outfile=$2

echo journalName > journals
echo orig > OG
echo reuse > RE

for j in Bioinformatics BMC_Bioinformatics BMC_Genomics BMC_Syst_Biol Genome_Biol Genome_Med Nat_Biotechnol Nat_Methods Nucleic_Acids_Res PLoS_Comput_Biol
do
	echo $j >> journals
	grep -E "^${j}" $infile | grep ,OG | wc -l >> OG
	grep -E "^${j}" $infile | grep ,RE | wc -l >> RE
done

paste -d ',' journals OG RE > $outfile
