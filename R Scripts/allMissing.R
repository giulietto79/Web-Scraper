# I first need to build a model to deal with the cases where all three
# potentially missing features are missing
library(ggplot2)
library(lattice)
library(caret)

rmse <- function(predictions, actual) {
      sqDif = (predictions - actual) ^ 2
      avgError = sum(sqDif) / length(predictions)
      return(sqrt(avgError))
}

allMissingObs <- is.na(factorData$Beds) & is.na(factorData$Baths) & is.na(factorData$Square.Feet)
allMissingData <- factorData[allMissingObs, ]
set.seed(6666)
trainIndex = createDataPartition(y = allMissingData$Price, p = 0.5, list = FALSE)
allMissingTest = allMissingData[-trainIndex, ]
allMissingTrain = as.data.frame(rbind(factorData[!allMissingObs, ], allMissingData[trainIndex, ]))

library(rpart)
allMissingTreeModel1 = train(Price ~ Latitude + Longitude + Neighborhood + House.Type,
                   data = allMissingTrain, method = "rpart",
                   trControl = trainControl(method = "cv", number = 10),
                   tuneGrid = data.frame(cp = c(seq(from=0.1, to=0.01, length.out = 5),
                                                seq(from=0.01, to=0.001, length.out=10),
                                                seq(from=0.001, to=0.0001, length.out=10))))
allMissingTreeModel1
predictions1 = predict(allMissingTreeModel1, allMissingTest)
rmse(predictions1, allMissingTest$Price)

allMissingTreeModel2 = rpart(Price ~ Latitude + Longitude + Neighborhood + House.Type,
                             data = allMissingTrain, cp = 0.0001)
printcp(allMissingTreeModel2)
plotcp(allMissingTreeModel2)
allMissingPrunedModel2 = prune(allMissingTreeModel2, cp = 0.004)
predictions2 = predict(allMissingPrunedModel2, allMissingTest)
rmse(predictions2, allMissingTest$Price)
