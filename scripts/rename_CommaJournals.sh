#!/bin/bash

# rename journal directories that include commas

cd /u/scratch/n/nikodm/pmcOA_05-05-2020/

for journal in $( ls | grep , ); do
	newname=$( echo $journal | sed "s/,//g" )
	mv $journal $newname
done
