# This is a project that is going to combine web scraping and data
# analysis. I am going to get information on real estate sales in
# Chcicago by scraping information from multiple websites. With that
# information, I might decide to predict house price by size, by
# location, or other factors. I might also do a geographical analysis.
# Visualizing the data would also be a cool task.

from bs4 import BeautifulSoup
from urllib2 import urlopen
import csv

def make_soup(url):
	html = urlopen(url).read()
	return BeautifulSoup(html, "lxml")

def get_house_details(house):
	pass