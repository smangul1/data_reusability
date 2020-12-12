import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractAuthors(paperName):
	# throw an exception that the file exists
	try:
		root=ET.parse(paperName).getroot()
	except:
		print("cannot open ",paperName,", skipping..")
		return
	# get list of all contributors
	contribs = root.findall("./front/article-meta/contrib-group/contrib")
	# loop through each author, each author gets a line in csv
	for auth in contribs:
		journal = paperName.split('/')[-2]
		paper = paperName.split('/')[-1].split('.')[0]
		# extract names, checking against MISSING name field
		try:
			lastname = auth.findall("./name/surname")[0].text
		except:
			lastname = 'MISSING'
		try:
			firstname = auth.findall("./name/given-names")[0].text		
		except:
			firstname = 'MISSING'	
		# check against EMPTY name field (labeled as MISSING in csv)
		if type(firstname) != str:
			firstname = 'MISSING'
		if type(lastname) != str:
			lastname = 'MISSING'
		# print a line to the csv
		#print(journal + "," + paper + "," + lastname + "," + firstname + ",")
		print(journal + ',' + paper + ',' + lastname + ',' + firstname)

file=open(filename)
list=[line[:-1] for line in file]

# loop through every file path in the list we're passed from extractAuthors.sh
for i in list:
	extractAuthors(i)
