import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]

def extractFirstDate(paperName):
	try:
		root=ET.parse(paperName).getroot()
	except:
		return "missing_file:" + paperName
	dates = []	
	for date in root.findall('./front/article-meta/pub-date/'):
		try: 
			y = date.findall('./year')[0].text
		except:
			y = 'NaN'
		try:
			m = date.findall('./month')[0].text
		except:
			m = '01'
		try:
			d = date.findall('./day')[0].text
		except:
			d = '01'
		if y != 'NaN':
			dates.append(y + '-' + m + '-' + d)
	if len(dates) == 0:
		return 'NaN'
	else:
		return dates[0]

file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	p = i.split('/')[-1].split('.')[0]
	print(p + ',' + extractFirstDate(i))

