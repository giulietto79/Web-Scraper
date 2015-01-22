# Now, I will build a model that uses square feet
library(ggplot2)
library(lattice)
library(caret)

rmse <- function(predictions, actual) {
      sqDif = (predictions - actual) ^ 2
      avgError = sum(sqDif) / length(predictions)
      return(sqrt(avgError))
}

bedsMissingObs <- is.na(factorData$Beds)
bedsMissingData <- factorData[bedsMissingObs, ]
set.seed(666)
trainIndex = createDataPartition(y = bedsMissingData$Price, p = 0.5, list = FALSE)
bedsMissingTest = bedsMissingData[-trainIndex, ]
bedsMissingTrain = as.data.frame(rbind(factorData[!bedsMissingObs, ], bedsMissingData[trainIndex, ]))

bedsMissingTreeModel1 = rpart(Price ~ Latitude + Longitude + Neighborhood + House.Type + Square.Feet,
                              data = bedsMissingTrain, cp = 0.0001)
printcp(bedsMissingTreeModel1)
plotcp(bedsMissingTreeModel1)
bedsMissingPrunedModel1 = prune(bedsMissingTreeModel1, cp = 0.0015)
predictions1 = predict(bedsMissingPrunedModel1, bedsMissingTest)
rmse(predictions1, bedsMissingTest$Price)


