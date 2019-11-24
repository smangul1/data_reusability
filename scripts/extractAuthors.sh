#!/bin/bash

infile=$1
outfile=$2

. /u/local/Modules/default/init/modules.sh
module load python/3.7.2


echo 'authors' > $outfile

# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # get script directory
# python3 $DIR/extractAuthors.py $infile >> $outfile

python3 ./extractAuthors.py $infile >> $outfile

