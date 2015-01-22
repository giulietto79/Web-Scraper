# Now, I will build a model that uses all variables
library(ggplot2)
library(lattice)
library(caret)

rmse <- function(predictions, actual) {
      sqDif = (predictions - actual) ^ 2
      avgError = sum(sqDif) / length(predictions)
      return(sqrt(avgError))
}

bathsMissingTreeModel1 = rpart(Price ~ Latitude + Longitude + Neighborhood + House.Type + Square.Feet + Beds,
                              data = bathsMissingTrain, cp = 0.0001)
printcp(bathsMissingTreeModel1)
plotcp(bathsMissingTreeModel1)
bathsMissingPrunedModel1 = prune(bathsMissingTreeModel1, cp = 0.0004)
bathsMissingpred1 = predict(bathsMissingPrunedModel1, bathsMissingTest)
rmse(bathsMissingpred1, bathsMissingTest$Price)


# I want to get some experience with support vector machines
library(kernlab)
bathsMissingSVM1 = train(form = Price ~ Latitude + Longitude + Neighborhood + House.Type + Square.Feet + Beds,
                         data = bathsMissingTrain,
                         method = "svmLinear",
                         trControl = trainControl("cv"),
                         tuneGrid = data.frame(C = seq(from=0.5, to=20, by=0.5)))
bathsMissingSVM1
bathsMissingpred2 = predict(bathsMissingSVM1, bathsMissingTest)
rmse(bathsMissingpred2, bathsMissingTest$Price)

# Polynomial Kernel
bathsMissingSVM2 = train(form = Price ~ Latitude + Longitude + Neighborhood + House.Type + Square.Feet + Beds,
                         data = bathsMissingTrain,
                         method = "svmPoly",
                         trControl = trainControl("cv"),
                         tuneGrid = expand.grid(C = seq(from=0.5, to=5, by=0.5),
                                               degree = seq(from=0.5, to=3, by=0.5),
                                               scale=c(1, 2, 3, 4, 5)))
bathsMissingSVM2
bathsMissingpred3 = predict(bathsMissingSVM2, bathsMissingTest)
rmse(bathsMissingpred3, bathsMissingTest$Price)

# Radial Kernel
bathsMissingSVM3 = train(form = Price ~ Latitude + Longitude + Neighborhood + House.Type + Square.Feet + Beds,
                         data = bathsMissingTrain,
                         method = "svmPoly",
                         trControl = trainControl("cv"),
                         tuneGrid = expand.grid(C = seq(from=0.5, to=5, by=0.5),
                                                sigma = seq(from=0.5, to=5, by=0.5)))
bathsMissingSVM3
bathsMissingpred4 = predict(bathsMissingSVM3, bathsMissingTest)
rmse(bathsMissingpred4, bathsMissingTest$Price)
