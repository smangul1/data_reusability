import xml.etree.ElementTree as ET
import sys

filename=sys.argv[1]


import datetime
import calendar

MAXMONTH = 12

def zeroPad(num):
	if int(num) < 10 and int(num) >= 0:
		return '0' + str(num)
	else:
		return str(num)

def extractFirstDate(paperName):
		# read file
        try:
                root=ET.parse(paperName).getroot()
        except:
                return "missing_file:" + paperName
        # list of datetime objects
        dates = []
        for date in root.findall('./front/article-meta/pub-date/'):
                try: # is there a year?
                        y = int(date.findall('./year')[0].text)
                except:
                		continue
                try: # is there a month?
                        m = int(date.findall('./month')[0].text)
                except:
                		# last month of the year
                		m = MAXMONTH
                try: # is there a day?
                        d = int(date.findall('./day')[0].text)
                except:
                		# last day of the month
                		d = int(calendar.monthrange(y, m)[1])
               	thisDate = datetime.date(y, m, d)
                dates.append(thisDate)
        if len(dates) == 0:
                return 'NaN'
        else:
        	dates.sort()
                minDate_asString = str(dates[0].year) + '-' + zeroPad(dates[0].month) + '-' + zeroPad(dates[0].day)
                return minDate_asString




file=open(filename)
list=[line[:-1] for line in file]

for i in list:
	p = i.split('/')[-1].split('.')[0]
	print(p + ',' + extractFirstDate(i))

