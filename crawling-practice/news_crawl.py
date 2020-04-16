import pymysql

import requests
from bs4 import BeautifulSoup
import re

conn = pymysql.connect(host='localhost', user='jspemp', password='1234',db='jspinsa', charset='utf8')
cur = conn.cursor()
cur.execute("use jspinsa")


def store(title, url):
	cur.execute('insert into news_pages (title, url) values (%s,%s)',(title, url))
	conn.commit()


def getLinks():
	url='http://news.etnews.com/'
	resp= requests.get(url)
	html = resp.content
	bsObj = BeautifulSoup(html, 'html.parser')
	
	
	title = bsObj.findAll('strong')
	for i in range(3,len(title)):
		a = title[i].a
		title_temp=title[i].get_text()
		url=a.attrs['href']
		store(title_temp, url)
		# print(newurl)


#메인
getLinks()

cur.close()
conn.close()
