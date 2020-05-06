import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractNumCitations(paperName):
	root = ET.parse(paperName).getroot()
	for i in root.iter('element-citation'):
		print(paperName, i.tag, i.attrib, i.text)

file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	extractNumCitations(i)

