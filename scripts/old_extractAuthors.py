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
	# extract the journal name, paper name, and authors' full names, one at a time
	# loop runs twice for each author, surname and given names alternate in the XML files
	for i in root.findall("./front/article-meta/contrib-group/contrib/name/"):
		journal = paperName.split('/')[-2]
		paper = paperName.split('/')[-1].split('.')[0]
		#try:
		#	a = root.findall("./front/article-meta/contrib-group/aff")
		#	address = a[0].text
		#except:
		#	print("missing address")
		#	return
		if i.tag == "surname":
			ln = i.text
		if i.tag == "given-names":
			fn = i.text
			if type(fn) != str:
				fn = 'MISSING'
			if type(ln) != str:
				ln = 'MISSING'
			print(journal + "," + paper + "," + ln + "," + fn + ",")

file=open(filename)
list=[line[:-1] for line in file]

# loop through every file path in the list we're passed from extractAuthors.sh
for i in list:
	extractAuthors(i)
