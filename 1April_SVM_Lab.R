library(e1071)
set.seed(1)

## Generating the observations which belong to 2 classes
x=matrix(rnorm(20*2),ncol=2)
y=c(rep(-1,10),rep(1,10))
x
y

## Checking whether the classes are linearly separable
plot(x, col=(3-y))
## They are not. Next, we fit the support vector classifier. 

# Note that in order for the svm() function to perform classification
# we must encode the response as a factor variable.
# We now create a data frame with the response coded as a factor.

dat <- data.frame(x=x,y=as.factor(y))
dat

svmfit <- svm(y~., data=dat, kernel = "linear", cost = 10, scale = FALSE)
# The argument scale=FALSE tells the svm() function not to scale each feature to 
# have mean zero or standard deviation one;
# depending on the application, one might prefer to use scale=TRUE.

plot(svmfit, dat)

svmfit$index
summary(svmfit)


svmfit2 <- svm(y ~., data=dat, kernel="linear", cost = 0.1, scale=FALSE)
plot(svmfit2,dat)
svmfit2$index



set.seed(1)
tune.out <- tune(svm, y~.,
                 data=dat,
                 kernel="linear",
                 ranges=list(cost=c(0.001, 0.01, 0.1, 1,5,10,100)))
# We can easily access the cross-validation errors for each of these models 
# using the summary() command:
summary(tune.out)

# We see that cost=0.1 results in the lowest cross-validation error rate.

# The tune() function stores the best model obtained, which can be accessed as follows:

bestmod <- tune.out$best.model
bestmod

#Generating a test datset

xtest = matrix(rnorm(20*2),ncol=2)
ytest = sample(c(-1,1),20,rep=TRUE)
xtest[ytest==1,]=xtest[ytest==1,]+1

testdat = data.frame(x=xtest, y=as.factor(ytest))

# Predit the class of the test data
# We will use the best model obtained previously

ypred <- predict(bestmod,testdat)
table(predict=ypred, actual=testdat$y) ## We can notice 14 values are correctly
# predicted with the cost value of 0.1


## Using cost = 0.01

svmfit3 <- svm(y~., data=dat, kernel="linear", cost=.01, scale=FALSE)
ypred=predict(svmfit ,testdat)
table(predict=ypred, truth=testdat$y) ## Here now 17 are correctly predicted

