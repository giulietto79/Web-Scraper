# I am going to build a web scraper to help get a geographical
# breakdown of the Neighborhoods

from bs4 import BeautifulSoup
from urllib2 import urlopen
import csv
import time

pageURL = "http://yochicago.com/chicago-neighborhoods/"

def make_soup(url):
	htmlOpen = urlopen(url)
	html = htmlOpen.read()
	return BeautifulSoup(html, "lxml")

def get_neighborhood_regions(soup):
	all_data = soup.find("div", "neighborhoodcols")
	regions = all_data.findAll("div")
	neighborhoodList = []
	for region in regions[0:6]:
		regionName = region.find("h3").string
		neighborhoods = [neighborhood.get_text() for neighborhood in region.findAll("a")]
		neighborhoodList = neighborhoodList.append([regionName] + neighborhoods)
	return neighborhoodList

soup = make_soup(pageURL)
neighborhoodList = get_neighborhood_regions(soup)

csvFile = open("Data/Neighborhoods.csv", "w")
output = csv.writer(csvFile, delimiter = ",")
for element in neighborhoodList:
	output.writerow(element)





