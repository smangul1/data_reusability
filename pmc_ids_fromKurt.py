import xml.etree.ElementTree as ET
import requests
import csv

pmc_id_converter_url = "https://www.ncbi.nlm.nih.gov/pmc/utils/idconv/v1.0/?ids="


def write_chunk(tsv_writer, experiments):
    for experiment in experiments:
        # Skip microarray-only experiments.
        if "RNA-SEQ" not in experiment["technologies"]:
            continue

        if experiment["pubmed_id"]:
            try:
                pmc_id_response = requests.get(pmc_id_converter_url + experiment["pubmed_id"])
                xml = ET.fromstring(pmc_id_response.text)
                for item in xml:
                    if item.tag == "record":
                        experiment["pmcid"] = item.attrib["pmcid"]
            except Exception:
                # A lot of experiments don't have pmcids, that's okay.
                pass

        tsv_writer.writerow(
            [
                experiment["accession_code"],
                experiment["alternate_accession_code"],
                experiment["pubmed_id"],
                experiment.get("pmcid", None),
            ]
        )


experiments_response = requests.get("http://api.refine.bio/v1/experiments/")
experiments_json = experiments_response.json()

output_file = "pubmed_mappings.tsv"

with open(output_file, "w") as output:
    tsv_writer = csv.writer(output, delimiter="\t")
    tsv_writer.writerow(["SRA_accession_code", "GEO_accession_code", "pubmed_id", "pmcid"])

    write_chunk(tsv_writer, experiments_json["results"])

    while experiments_json["next"]:
        experiments_response = requests.get(experiments_json["next"])
        experiments_json = experiments_response.json()

        write_chunk(tsv_writer, experiments_json["results"])
