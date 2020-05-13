#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=8G,h_rt=12:00:00
#$ -o extractDate.sh.log

infile="../data_lists/pmc_paths.txt"
outfile="../data_lists/preFilterDates.csv"

#. /u/local/Modules/default/init/modules.sh
#module load python/3.7.2

echo 'pmc_ID,date' > $outfile
python ./extractDate.py $infile >> $outfile
