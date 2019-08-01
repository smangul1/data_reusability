#!/bin/bash

indir=$1

ls $indir | grep -E "[)(]" > ~/data_reusability/fixthese.txt

while read dir
do

	newname=$(echo $dir | sed -e 's/(/_/g' | sed -e 's/)/_/g')
	mv $indir/$dir $indir/$newname

done < ~/data_reusability/fixthese.txt
