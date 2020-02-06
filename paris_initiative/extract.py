import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractAuthors(paperName):
	try:
		root=ET.parse(paperName).getroot()
	except:
		print("cannot open",paperName,", skipping..")
		return
	print("publication", "|", paperName)
	for i in root.findall("./front/article-meta/contrib-group/contrib/name/"):
		print(i.tag, "|",i.text)

file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	extractAuthors(i)
