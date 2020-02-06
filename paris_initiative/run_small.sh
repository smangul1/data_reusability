#!/bin/bash

infile=filepaths_bioinfo.txt
outfile=out_small.txt

. /u/local/Modules/default/init/modules.sh
module load python/3.7.2

python3 extract.py $infile > $outfile
