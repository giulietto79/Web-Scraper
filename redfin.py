# This is a project that is going to combine web scraping and data
# analysis. I am going to get information on real estate sales in
# Chcicago by scraping information from multiple websites. With that
# information, I might decide to predict house price by size, by
# location, or other factors. I might also do a geographical analysis.
# Visualizing the data would also be a cool task.

from bs4 import BeautifulSoup
from urllib2 import urlopen
import csv, sys

def make_soup2(url):
	hdr = {'User-Agent': 'Mozilla/5.0'}
	req = urllib2.Request(url, headers=hdr)
	page = urllib2.urlopen(req)
	return BeautifulSoup(page, "lxml")

def get_information():
	pass
