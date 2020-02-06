import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractAddress(paperName):
	# throw an exception that the file exists
	try:
		root=ET.parse(paperName).getroot()
	except:
		print("cannot open ",paperName,", skipping..")
		return
	aff = root.findall("./front/article-meta/contrib-group/aff")
	try:
		address = aff[0].text
	except:
		address = 'MISSING'
	if type(address) != str:
		address = 'MISSING'
	print(address)
        
file=open(filename)
list=[line[:-1] for line in file]

# loop through every file path in the list we're passed from extractAddress.sh
for i in list:
	extractAddress(i)
