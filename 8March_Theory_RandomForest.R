########## March 8 In-Class Work #######

####### Mean Squared Error, LOOCV, K-Fold Cross Validation, Random Forest #######

## Mean Squared Error ##

library(ISLR)
library(MASS)
library(boot)

set.seed(1)

??cv.glm

help("sample")

train <- sample(392,196)

lm.fit <- lm(mpg~horsepower, data = Auto, subset = train)

attach(Auto)
mean((mpg-predict(lm.fit, Auto))[-train]^2)
#### MSE for the linear regression is 23.26601

### Estimating test error for quadratic and cubic regression

lm.fit2 <- lm(mpg~poly(horsepower,2), data = Auto, subset = train) #Quadratic
mean((mpg-predict(lm.fit2, Auto))[-train]^2)
#### MSE for the quadratic is 18.71646

lm.fit3 <- lm(mpg~poly(horsepower,3), data = Auto, subset = train) # Cubic
mean((mpg-predict(lm.fit3, Auto))[-train]^2)
### MSE for the cubic is 18.79401

#### Choose other training set

set.seed(2)
train2 <- sample(392,196)
lm.fit <- lm(mpg~horsepower, data = Auto, subset = train)
mean((mpg-predict(lm.fit,Auto))[-train]^2)
##### MSE for the linear regression is 23.29601

lm.fit2 <- lm(mpg~poly(horsepower,2), data = Auto, subset = train) # Quadratic
mean((mpg-predict(lm.fit2,Auto))[-train]^2)
# the error rate is 18.90

lm.fit3 <- lm(mpg~poly(horsepower,3), data = Auto, subset = train) # Cubic 
mean((mpg-predict(lm.fit3,Auto))[-train]^2)
# the error rate is 19.25




###### K Fold on Auto Dataset #########

set.seed(17)
help("rep") # read documentation, help("rep")
cv.error.10 = rep(0,10)
for(i in 1:10){
  glm.fit = glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error.10[i] = cv.glm(Auto,glm.fit, K=10) $delta[1] }
cv.error.10

######### Random Forest Example ######

#Car Acceptability dataset from UCI ML Repository
#Data Source - https://archive.ics.uci.edu/ml/machine-learning-databases/car/

install.packages("randomForest")
library(randomForest)

carData <- read.csv(file.choose(), header = T)
head(carData)

#Add Column Names
colnames(carData) <- c("BuyingPrice","Maintainance","NumDoors","NumPersons"
                       ,"BootSpace","Safety","Condition")
head(carData)
str(carData)
levels(carData$Condition)
summary(carData)

#Choosing 'Training' and 'Validation' data set
#Randomly choose 70%(0.7) of the data to be testing data and rest as validation

set.seed(100)
train <- sample(nrow(carData), 0.7*nrow(carData), replace = FALSE)
TrainSet <- carData[train,]
ValidationSet <- carData[-train,]
summary(TrainSet)
summary(ValidationSet)

help("randomForest")

attach(carData)
#Random Forest Model with default parameters
model1 <- randomForest(Condition ~.,data = TrainSet, importance = TRUE)
model1

#Modifying the parameters of the randomForest model
model2 <- randomForest(Condition ~ . , data = TrainSet,
                       ntree = 500,
                       mtry = 6,
                       importance = TRUE)
model2


#First we will conduct prediction using training set and then we will do
#prediction on the Validation Set
# We are doing this to see the difference in results

#Predicting on training dataset
predTrain <- predict(model2, TrainSet, type = 'class')

#Use table() to check the classification accuracy
table(predTrain, TrainSet$Condition)

#Predicting on Validation dataset
predValid <- predict(model2, ValidationSet, type = 'class')
table(predValid, ValidationSet$Condition)


#Use importance() function to check important variables
#The below functions show the drop in mean accuracy for each of the variables

#Check the important variables
importance(model2)
varImpPlot(model2)

#Using a 'for' loop to check and try different values of mtry

a=c()
i = 5
for (i in 3:8)
{
  model3 <- randomForest(Condition ~ ., data = TrainSet, ntree = 500,
                         mtry = i,
                         importance = TRUE)
  predValid <- predict(model3, ValidSet, type = 'class')
  a[i-2] = mean(predValid == ValidationSet$Condition)
}
a
plot(3:8,a)


#Comparision with Decision Tree
install.packages('caret')
install.packages('e1071')
library(rpart)
library(caret)
library(e1071)

#We will compare model1 of Random Forest with Decision Tree model

model_dt <- train(Condition ~ ., data=TrainSet, method = 'rpart')
model_dt_1 <- predict(model_dt, data = TrainSet)

table(model_dt_1, TrainSet$Condition)
mean(model_dt_1 == TrainSet$Condition)


#Running on Validation Set
model_dt_vs <- predict(model_dt, newdata = ValidationSet)
table(model_dt_vs, ValidationSet$Condition)
mean(model_dt_vs == ValidationSet$Condition)
### mean == 0.7764933