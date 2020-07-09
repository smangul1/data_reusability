#!/usr/bin/env python
#$ -S /u/local/apps/python/2.7.3/bin/python
#$ -cwd
#$ -j y
#$ -pe shared 12
#$ -l h_data=4000M,h_rt=24:00:00
#$ -v QQAPP=openmp
#$ -v LD_LIBRARY_PATH
#$ -v PYTHON_LIB
#$ -v PYTHON_DIR
#$ -m n
#$ -r n
#$ -o download_refs.py.log

# import modules
import os

################################
## download GEO reference data
################################

# samples
# max page size is 5000, number of pages is total number of "sample" datasets / 5000
# page sizes updated 2020-06-16
NUM_SAMPLE_PAGES = 728
os.system("echo 'Accession,Title,Sample_Type,Taxonomy,Channels,Platform,Series,Supplementary_Types,Supplementary_Links,SRA_Accession,Contact,Release_Date' > ./geo_samples.csv")
for i in range(1, NUM_SAMPLE_PAGES):
    url = 'https://www.ncbi.nlm.nih.gov/geo/browse/?view=samples&sort=date&mode=csv&page=' + str(i) + '&display=5000'
    # os.system("wget -c --read-timeout=5 --tries=0 " + url + "-O ./samples_" + str(i) + ".csv")
    os.system("wget " + url + " -O ./samples_" + str(i) + ".csv")
    os.system("sed 1d ./samples_" + str(i) + ".csv >> ./geo_samples.csv")
    os.system("rm -f ./samples_" + str(i) + ".csv")

# series
NUM_SERIES_PAGES = 27
os.system("echo 'Accession,Title,Series_Type,Taxonomy,Sample_Count,Datasets,Supplementary_Types,Supplementary_Links,PubMed_ID,SRA_Accession,Contact,Release_Date' > ./geo_series.csv")
for i in range(1, NUM_SERIES_PAGES):
    url = 'https://www.ncbi.nlm.nih.gov/geo/browse/?view=series&sort=date&mode=csv&page=' + str(i) + '&display=5000'
    # os.system("wget -c --read-timeout=5 --tries=0 " + url + " -O ./series_" + str(i) + ".csv""")
    os.system("wget " + url + " -O ./series_" + str(i) + ".csv")
    os.system("sed 1d ./series_" + str(i) + ".csv >> ./geo_series.csv")
    os.system("rm -f ./series_" + str(i) + ".csv")

# platforms
NUM_PLATFORM_PAGES = 5
os.system("echo 'Accession,Title,Technology,Taxonomy,Data_Rows,Samples_Count,Series_Count,Contact,Release_Date' > ./geo_platforms.csv")
for i in range(1, NUM_PLATFORM_PAGES):
    url = 'https://www.ncbi.nlm.nih.gov/geo/browse/?view=platforms&sort=date&mode=csv&page=' + str(i) + '&display=5000'
    # os.system("wget -c --read-timeout=5 --tries=0 " + url + " -O ./platforms_" + str(i) + ".csv")
    os.system("wget " + url + " -O ./platforms_" + str(i) + ".csv")
    os.system("sed 1d ./platforms_" + str(i) + ".csv >> ./geo_platforms.csv")
    os.system("rm -f ./platforms_" + str(i) + ".csv")

################################
## download SRA reference data
################################

sources = ["genomic", "genomic single cell", "metagenomic", "metatranscriptomic", "other", "synthetic", "transcriptomic", "transcriptomic single cell", "viral rna"]
filenames = ["genomic", "genomic_single_cell", "metagenomic", "metatranscriptomic", "other", "synthetic", "transcriptomic", "transcriptomic_single_cell", "viral_rna"]

#Downloads csv for each source
for i in range(0, 9):
    os.system("wget http://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&db=sra&rettype=runinfo&term=" + sources[i] + "[Source]' -O ./sra_runs_" + filenames[i] + ".csv")
    
#Creates the final csv with header    
os.system("echo 'Run,ReleaseDate,LoadDate,spots,bases,spots_with_mates,avgLength,size_MB,AssemblyName,download_path,Experiment,LibraryName,LibraryStrategy,LibrarySelection,LibrarySource,LibraryLayout,InsertSize,InsertDev,Platform,Model,SRAStudy,BioProject,Study_Pubmed_id,ProjectID,Sample,BioSample,SampleType,TaxID,ScientificName,SampleName,g1k_pop_code,source,g1k_analysis_group,Subject_ID,Sex,Disease,Tumor,Affection_Status,Analyte_Type,Histological_Type,Body_Site,CenterName,Submission,dbgap_study_accession,Consent,RunHash,ReadHash' > ./sra_complete_runs.csv")

#Removes first line and concatenates all csvs
for i in range(0, 9):
    os.system("sed 1d ./sra_runs_" + filenames[i] + ".csv >> ./sra_complete_runs.csv")
