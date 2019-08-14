import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractMinDate(paperName):
	tree=ET.parse(paperName)
	root=tree.getroot()
	list=[]
	for i in root.findall("./front/article-meta/pub-date/year"):
		list.append(i.text)
	if len(list)==0:
		year='NA'
	else:
		year=min(list)
	return year

file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	print(extractMinDate(i))

