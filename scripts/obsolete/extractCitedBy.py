# This script takes in an article title and outputs the number 
# of citations Google Scholar reports for that article.

import scholarly
import sys

filename=sys.argv[1]

def getCitations(title):
	search_query = scholarly.search_pubs_query(title)
	try:
		pub = next(search_query)
		print(pub.citedby)
	except:
		print("bamboozled!")	

file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	if(i == "None"):
		print("missing_title")
	else:
		getCitations(i)
