#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=48G,h_rt=24:00:00
#$ -o preFilterPMCscrape.sh.log

indir="/u/scratch/n/nikodm/pmcOA_05-05-2020/"
outfile="../data_tables/preFilterMatrix.csv"

# extract papers that contain SRA or GEO accession numbers from input folder
grep -o -r -E -H \
-e "[SDE]R[APXRSZ][0-9]{6,7}" \
-e "PRJNA[0-9]{6,7}" \
-e "PRJD[0-9]{6,7}" \
-e "PRJEB[0-9]{6,7}" \
-e "GDS[0-9]{1,6}" \
-e "GSE[0-9]{1,6}" \
-e "GPL[0-9]{1,6}" \
-e "GSM[0-9]{1,6}" \
$indir > ../data_lists/rawPubData.txt

# reformat the raw scraped data into a csv
echo "pmc_ID,accession" > ../data_lists/pmcAndAccs.csv
awk -F "[/.:]" '{print $8","$10}' ../data_lists/rawPubData.txt >> ../data_lists/pmcAndAccs.csv

# make a column of journal names
echo "journal" > ../data_lists/journalNames.txt
awk -F "/" '{print $7}' ../data_lists/rawPubData.txt >> ../data_lists/journalNames.txt

paste -d ',' ../data_lists/journalNames.txt ../data_lists/pmcAndAccs.csv > $outfile


