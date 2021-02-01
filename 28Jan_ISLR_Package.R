install.packages("ISLR")

library(ISLR)
data(Auto)
help("Auto")
head(Auto, 10) #will show first 10 rows
tail(Auto) #will show last 6
names(Auto)
summary(Auto)
summary(Auto$mpg)
fivenum(Auto$mpg)
boxplot(Auto$mpg)
hist(Auto$mpg)
summary(Auto$horsepower)
summary(Auto$weight)
fivenum(Auto$weight)
boxplot(Auto$weight)
mean(Auto$weight)
median(Auto$weight)
