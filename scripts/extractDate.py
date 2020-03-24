import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractFirstDate(paperName):
	try:
		root=ET.parse(paperName).getroot()
	except:
		return "missing_file:" + paperName	
	years=[]
	mons=[]
	days=[]
	for y in root.findall("./front/article-meta/pub-date/year"):
		years.append(y.text)
	for m in root.findall("./front/article-meta/pub-date/month"):
		mons.append(m.text)
	for d in root.findall("./front/article-meta/pub-date/day"):
		days.append(d.text)
	if len(years) == 0:
		return 'NaN'
	else:
		yr = years[0]
	if len(mons) == 0:
		mn = '01'
	else:
		mn = mons[0]
	if len(days) == 0:
		dy = '01'
	else:
		dy = days[0]
	date = yr + '-' + mn + '-' + dy
	return date

file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	p = i.split('/')[-1].split('.')[0]
	print(p + ',' + extractFirstDate(i))

