#!/bin/bash

infile=.././data_lists/filepaths.txt
outfile=out.txt

. /u/local/Modules/default/init/modules.sh
module load python/3.7.2

python3 extract.py $infile > $outfile
