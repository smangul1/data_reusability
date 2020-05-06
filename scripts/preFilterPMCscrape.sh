#!/bin/bash
#$ -cwd
#$ -l h_data=48G,h_rt=24:00:00
#$ -o preFilterPMCscrape.sh.log

indir="/u/scratch/n/nikodm/pmcOA_2020-05-05/"
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
$indir > rawPubData.txt

# reformat the raw scraped data into a csv
echo "pmc_ID,accession" > pmcAndAccs.csv
awk -F "[/.:]" '{print $8","$10}' rawPubData.txt >> pmcAndAccs.csv

# make a column of journal names
echo "journal" > journalNames.txt
awk -F "/" '{print $7}' rawPubData.txt >> journalNames.txt

paste -d ',' journalNames.txt pmcAndAccs.csv > $outfile


