# Data Reusability Pipeline

## Download data

Download the most recent open access subset of PubMed Central publications. Then rename journals with commas in their names to avoid issues downstream

```bash
cd scripts
./download_publications.sh
./rename_CommaJournals.sh
cd ../
```

## Select papers mentioning SRA or GEO

Parse the text of every publication for regular expressions matching SRA and GEO accession IDs

```bash
cd scripts
./preFilterPMCscrape.sh
cd ../
```


