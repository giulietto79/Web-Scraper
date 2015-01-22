rawData = read.csv("Data/truliafirst500.csv", stringsAsFactors = FALSE)
# There is some problem with the quotes. Perhaps it has to do
# with the unicode strings. I don't know...

factors = c("Date.Sold", "Neighborhood", "House.Type")
factorData = rawData
for(var in factors) {
      factorData[, var] = as.factor(factorData[, var])
}

factorData = factorData[!is.na(factorData$Price), ]

rm(var)
