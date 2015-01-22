# Some exploratory analysis that will help build models

apply(is.na(factorData), 2, sum)

test1 = is.na(factorData$Beds)
test2 = is.na(factorData$Baths)
test3 = is.na(factorData$Square.Feet)
# The first thing that I will try to do is build a model that
# predicts house price based on house size

str(rawData)
rawData[1,]
apply(is.na(rawData), 2, sum)
hist(table(rawData$Neighborhood))

# I just built a w web scraper to get a list of the regions in Chicago
# with the associated neighborhoods in them
neighborhoodList = read.csv("Data/Neighborhoods.csv", header = FALSE)
downtown = neighborhoodList[1, 2:ncol(neighborhoodList)]

sqftData = trulia[!is.na(trulia$Size.in.Square.Feet), c("Price", "Neighborhood", "Size.in.Square.Feet")]
plot(y = sqftData$Price, x = sqftData$Size.in.Square.Feet)
fit1 = lm(Price ~ Size.in.Square.Feet, data = sqftData)
abline(fit1, col = "red")

fit2 = lm(Price ~ Neighborhood, data = trulia)

fit3 = lm(Price ~ Neighborhood + Size.in.Square.Feet, data = sqftData)

sort(tapply(trulia$Price, trulia$Neighborhood, mean))




