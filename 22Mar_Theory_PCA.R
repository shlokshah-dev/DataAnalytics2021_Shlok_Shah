#### 22nd March 2021 - In-Class Work ####

##### Principal Component Analysis (PCA) ####

library(rpart)
library(stats)


###### IRIS Dataset #######

data("iris")
head(iris)

# Removing the Speices column from the data set, to only include numerical
#data for PCA

irisdata1 <- iris[,1:4]
head(irisdata1)
dim(irisdata1)


#Using the princomp() function to calculate the Principal Components
help("princomp")
principal_components <- princomp(irisdata1, cor = TRUE, scores = TRUE)

summary(principal_components)
# In the summary we can see that the first 2 components make up to alomost 95.8%
#of the principal component. Hence, they can be taken as the 2 main Principal 
#Components

plot(principal_components)

#Plotting using a line
plot(principal_components, type = "l")
#We can see from the line plot that the elbow comes after the second component.
#This again goes to show that the third and the fourth component can be ignored

help("biplot")
biplot(principal_components)
#From the bi-plot we see that the Petal Length and Petal Width are very close by
#and Sepal Width and Sepal length are far away. So that is why to properly 
#use classification, we should use Petal length and Petal width





###############################################################################


###################### PCA on Boston Dataset ##########################

data(Boston, package = "MASS")

help("prcomp")
pca_out <- prcomp(Boston, scale. = T)
pca_out
#This shows the loading that is used
plot(pca_out)



#Plotting using bi-plot

biplot(pca_out,scale = 0)

boston_pc <- pca_out$x
boston_pc

head(boston_pc)
summary(boston_pc)
