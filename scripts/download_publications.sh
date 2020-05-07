#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=48G,h_rt=24:00:00
#$ -o download_publications.sh.log

date=$(date +"%m-%d-%Y")

cd /u/scratch/n/nikodm/

mkdir -p pmcOA_${date}
cd pmcOA_${date}

# download commercial use subset
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/comm_use.A-B.xml.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/comm_use.C-H.xml.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/comm_use.I-N.xml.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/comm_use.O-Z.xml.tar.gz

# download non-commercial use subset
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/non_comm_use.A-B.xml.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/non_comm_use.C-H.xml.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/non_comm_use.I-N.xml.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/non_comm_use.O-Z.xml.tar.gz

# unzip everything
tar -xf comm_use.A-B.xml.tar.gz
tar -xf comm_use.C-H.xml.tar.gz
tar -xf comm_use.I-N.xml.tar.gz
tar -xf comm_use.O-Z.xml.tar.gz
tar -xf non_comm_use.A-B.xml.tar.gz
tar -xf non_comm_use.C-H.xml.tar.gz
tar -xf non_comm_use.I-N.xml.tar.gz
tar -xf non_comm_use.O-Z.xml.tar.gz

# delete compressed files
rm -f *.tar.gz
