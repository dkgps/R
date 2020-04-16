import pymysql

import requests
from bs4 import BeautifulSoup
import re

conn = pymysql.connect(host='localhost', user='jspemp', password='1234',db='jspinsa', charset='utf8')
cur = conn.cursor()
cur.execute("use jspinsa")




def store(content,id):
	cur.execute('update news_pages set content =(%s) where id=(%s)',(content,id))
	cur.execute('update news_pages set search_yn ="y" where id=(%s)',(id))
	conn.commit()

def getContents():
	for i in range(1,21):
		sql = 'select url from news_pages where id='+str(i)
		cur.execute(sql)
		result = cur.fetchone()
		url=result[0]
	
		resp= requests.get(url)
		html = resp.content
		bsObj = BeautifulSoup(html, 'html.parser')
		
		content = bsObj.find('section',{'id':'articleBody'})
		title = bsObj.find('title')
		p_tag=content.p
		content_temp=p_tag.get_text()
		title_temp=title.get_text()
		store(content_temp,str(i))
		

getContents();

cur.close()
conn.close()
