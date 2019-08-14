import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractTitle(paperName):
	root=ET.parse(paperName).getroot()
	for i in root.findall("./front/article-meta/title-group/article-title"):
		print(i.text)

file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	extractTitle(i)
