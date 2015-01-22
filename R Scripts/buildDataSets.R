# Since there are subsets of the data that are missing, we have to create
# some training and testing sets for our different models.

# For the data where beds, baths, and sqft are all missing
# Training data
missingSqftObs <- is.na(factorData$Square.Feet)
missingSqftData <- factorData[missingSqftObs, ]
set.seed(666)
index1 <- createDataPartition(y = missingSqftData$Price, p = 0.5, list = FALSE)
allMissingTrain = as.data.frame(rbind(factorData[!missingSqftObs, ], missingSqftData[index1, ]))
# Testing data
allMissingTest = missingSqftData[-index1, ]

# For the data where, beds are missing (baths are always missing unfortunately)
# Training data
missingBedsObs <- is.na(factorData$Beds)
missingBedsData <- factorData[missingBedsObs, ]
set.seed(6)
index2 <- createDataPartition(y = missingBedsData$Price, p = 0.5, list = FALSE)
bedsMissingTrain = as.data.frame(rbind(factorData[!missingBedsObs, ], missingBedsData[index2, ]))
# Testing data
bedsMissingTest = missingBedsData[-index2, ]

# For the data where we have all information (except Baths)
# Training data
bathsMissingData = factorData[!missingBedsObs, ]
set.seed(66)
index3 <- createDataPartition(y = bathsMissingData$Price, p = 0.7, list = FALSE)
bathsMissingTrain = bathsMissingData[index3, ]
# Testing data
bathsMissingTest = bathsMissingData[-index3, ]


