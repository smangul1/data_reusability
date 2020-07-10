#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=8G,h_rt=2:00:00
#$ -o mouseStrainScrape.sh.log

outfile="../data_tables/mouse_strains.csv"
pathfile="../data_tables/mouse_paths.csv"

rm -f rawStrainData.txt
touch rawStrainData.txt

for pap in $( cat $pathfile ); do
    grep -o -i -E -H \
    -e "Mus musculus[^[:space:]^<]*" \
    -e "Mus musculus domesticus[^[:space:]^<]*" \
    -e "Mus musculus molossinus[^[:space:]^<]*" \
    -e "Mus musculus musculus[^[:space:]^<]*" \
    -e "Mus musculus castaneus[^[:space:]^<]*" \
    -e "Mus spretus[^[:space:]^<]*" \
    $pap >> rawStrainData.txt
done

echo "journal,pmc_ID" > journal_pmc.txt
awk -F "[/.]" '{print $7","$8}' rawStrainData.txt >> journal_pmc.txt
echo "mouse_strain" > str.txt
awk -F ":" '{print $2}' rawStrainData.txt >> str.txt
paste -d ',' journal_pmc.txt str.txt > $outfile
rm -f journal_pmc.txt str.txt rawStrainData.txt
