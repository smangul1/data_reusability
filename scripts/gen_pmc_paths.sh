#!/bin/bash

matrix_file="../data_tables/preFilterMatrix.csv"
path_file="../data_lists/pmc_paths.txt"

sed 1d $matrix_file | \
awk -F ',' '{print "/u/scratch/n/nikodm/pmcOA_05-05-2020/"$1"/"$2".nxml"}' | \
sort -u > ${path_file}
