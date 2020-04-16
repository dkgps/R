import requests
from bs4 import BeautifulSoup
import re
import csv

csv_file=open('zum_keyword.csv','w')
csv_file.write('순위, 검색어, 웹페이지URI\n')

url='http://zum.com/'
req=requests.get(url)
cont=req.content

bs=BeautifulSoup(cont,'html.parser')

link = bs.findAll('a',class_='d_btn_keyword',attrs={'style': 'top:22px'})

for i in link:
	csv_file.write('{0},{1},{2}\n'.format(i.get('data-order'),i.get('title'),i.get('href')))

csv_file.close()
