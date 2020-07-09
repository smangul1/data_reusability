#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=48G,h_rt=24:00:00
#$ -o mouseStrainScrape.sh.log

indir="/u/scratch/n/nikodm/pmcOA_05-05-2020/"
outfile="../data_tables/mouse_strains.csv"
pathfile="../data_tables/MINImouse_paths.csv"

touch rawStrainData.txt

for pap in $( cat $pathfile ); do
    grep -o -i -E \
    -e "Mus musculus\S*" \
    -e "Mus musculus domesticus\S*" \
    -e "Mus musculus molossinus\S*" \
    -e "Mus musculus musculus\S*" \
    -e "Mus musculus castaneus\S*" \
    -e "Mus spretus\S*"
    $pap >> rawStrainData.txt

done
