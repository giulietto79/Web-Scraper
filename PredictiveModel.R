trulia = read.csv("Data/trulia-info.csv")
# There is some problem with the quotes. Perhaps it has to do
# with the unicode strings. I don't know...

# The first thing that I will try to do is build a model that
# predicts house price based on house size

sqftData = trulia[!is.na(trulia$Size.in.Square.Feet), c("Price", "Neighborhood" "Size.in.Square.Feet")]
plot(y = sqftData$Price, x = sqftData$Size.in.Square.Feet)
fit1 = lm(Price ~ Size.in.Square.Feet, data = sqftData)
abline(fit1, col = "red")
summary(fit1)
