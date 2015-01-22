# This is a project that is going to combine web scraping and data
# analysis. I am going to get information on real estate sales in
# Chcicago by scraping information from multiple websites. With that
# information, I might decide to predict house price by size, by
# location, or other factors. I might also do a geographical analysis.
# Visualizing the data would also be a cool task.

from bs4 import BeautifulSoup
from urllib2 import urlopen
import csv
import time

baseURL = "http://www.trulia.com/sold/Chicago,IL"

def make_soup(url):
	try:
		htmlOpen = urlopen(url)
	except:
		print "Cant open"
	try:
		html = htmlOpen.read()
	except:
		print "cant read"
	try:
		soup = BeautifulSoup(html, "lxml")
		print "lml worked"
	except:
		try:
			soup = BeautifulSoup(html, "html.parser")
			print "html parser worked"
		except:
			print "The problem is the parser"
			return None
	return soup


def get_house_details(house):
	latitude = float(house.find("meta", attrs = {"itemprop": "latitude"})["content"])
	longitude = float(house.find("meta", attrs = {"itemprop": "longitude"})["content"])
	address = house.find("meta", attrs = {"itemprop": "streetAddress"})["content"]
	priceDate = house.find("span", "h4")
	price = priceDate.contents[1].string
	price = float(str(price[1:]).replace(",", ""))
	dateSold = priceDate.contents[3].string
	dateSold = str(dateSold.replace("Last sold on  ", ""))
	firstCol = house.find("div", "col cols6")
	neighborhood = firstCol.find("div", "typeTruncate").string
	moreAddress = house.find("div", "typeTruncate h7 mvn").get_text()
	bathsBeds = house.find("div", "col cols4").get_text()
	bathsBeds = bathsBeds.split()
	if "beds" in bathsBeds:
		beds = float(str(bathsBeds[bathsBeds.index("beds") - 1]))
	else:
		beds = None
	if "baths" in bathsBeds:
		baths = float(str(bathsBeds[bathsBeds.index("baths") - 1]))
	else:
		baths = None
	typeSize = house.find("div", "col cols5 typeTruncate")
	houseType = typeSize.contents[1].string
	try:
		sizeString = typeSize.find("div", "h7 mvn").string
		size = float(str(sizeString.split()[0]).replace(',', ''))
	except:
		size = None
	return [latitude, longitude, address, price, dateSold, neighborhood,
			moreAddress, beds, baths, houseType, size]

def first_page(baseURL):
	soup = make_soup(baseURL)
	houses = soup.findAll("li", "hover propertyCard property-data-elem")
	information = []
	for house in houses:
		houseInfo = get_house_details(house)
		information.append(houseInfo)
	return information

def get_houses(pageURL, information):
	try:
		soup = make_soup(pageURL)
	except:
		print "soup wrong"
	try:
		houses = soup.findAll("li", "hover propertyCard property-data-elem")
	except:
		print "cant find houses"
	try:
		print len(houses)
		for house in houses:
			houseInfo = get_house_details(house)
			information.append(houseInfo)
	except:
		print "get_house_details wrong"

information = first_page(baseURL)

for i in range(2, 500):
	nextURL = "http://www.trulia.com/sold/Chicago,IL/" + str(i) + "_p"
	time.sleep(30)
	get_houses(nextURL, information)
	print "page" + str(i)
	print len(information)

'''
csvFile = open("Data/trulia-info.csv", "w")
fieldNames = ("Latitude", "Longitude", "Street Address", "Price", "Date Sold",
				"Neighborhood", "More Address", "Beds", "Baths", "House Type",
				"Size in Square Feet")
output = csv.writer(csvFile, delimiter = ",")
output.writerow(fieldNames)

for house in information:
	output.writerow(house)

print "Done Writing File"

'''

