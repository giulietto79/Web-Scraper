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

def get_one_house(house):
	try:
		address = house.a["title"]
	except:
		address = None
	try:
		latitude = house.find(itemprop = "latitude")["content"]
		longitude = house.find(itemprop = "longitude")["content"]
	except:
		latitude = None
		longitude = None
	try:
		price = house.find("span", "listing-price listing-price-recentlysold").string
	except:
		price = None
	try:
		date = house.find("span", "listing-price-recentlysold listing-meta-noborder larger").string
	except:
		date = None
	try:
		beds = house.find("span", "listing-beds").contents[0].string
	except:
		beds = None
	try:
		fullBaths = house.find("span", "listing-baths").contents[0].string
	except:
		fullBaths = None
	try:
		halfBaths = house.find("span", "listing-baths").contents[2].string
	except:
		halfBaths = None
	try:
		houseType = house.find("span", "listing-property-type").string
	except:
		houseType = None
	try:
		sqft = house.find("span", "listing-sqft").contents[0].string
	except:
		sqft = None
	houseInfo = (address, latitude, longitude, price, date, beds, fullBaths, halfBaths, houseType, sqft)
	return houseInfo


soup = make_soup(pageURL)
listings = soup.findAll("ul", "listing-summary")
information = []
for house in listings:
	houseInfo = get_one_house(house)
	information.append(houseInfo)
return information

for i in range(2, 398):
	newPageURL = "http://www.realtor.com/soldhomeprices/Chicago_IL/sby-10/pg-" + i +"?pgsz=50"
	soup = make_soup(newPageURL)
	listings = soup.findAll("ul", "listing-summary")
	for house in listings:
		houseInfo = get_one_house(house)
		information.append(houseInfo)


