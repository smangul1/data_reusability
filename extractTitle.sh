#!/bin/bash

infile=$1
outfile=$2

. /u/local/Modules/default/init/modules.sh
module load python/3.7.2

echo 'title' > $outfile
python3 ./extractTitle.py $infile >> outfile
