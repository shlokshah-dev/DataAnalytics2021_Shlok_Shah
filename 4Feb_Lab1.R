# Feb 4 -- Lab 1 ###

#Creating Data Frames
#Example 1 - RPI Weather Information

days <- c('Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun') # days
temp <- c(28,30.5,32,31.2,29.3,27.9,26.4) #Temp in F during the week
snowed <- c('T','T','F','F','T','T','F') # T if it snowed on that day else F
help("data.frame")
RPI_Weather_Week <- data.frame(days,temp,snowed) #creating the dataframe using the data.frame() function

RPI_Weather_Week
head(RPI_Weather_Week) #head gives the first 6 rows of the dataframe

str(RPI_Weather_Week) #this helps us to look at the structure of the data frame

summary(RPI_Weather_Week) #summary of the dataframe

RPI_Weather_Week[1,] #shows the 1st row and all columns
RPI_Weather_Week[,1] #shows the 1st column and all rows

RPI_Weather_Week[,'snowed'] #gives all values for the snowed column
RPI_Weather_Week[,'days'] #gives all values for the days column
RPI_Weather_Week[,'temp'] #gives all values for the temp column
RPI_Weather_Week[1:5,c("days","temp")] # 1-5 rows for days and temp
RPI_Weather_Week$temp
subset(RPI_Weather_Week,subset=snowed==TRUE)

sorted.snowed <- order(RPI_Weather_Week['snowed'])
sorted.snowed
help("order")
RPI_Weather_Week[sorted.snowed,]
desc.temp <- order(-RPI_Weather_Week['temp'])
desc.temp

desc.snowed <- order(-xtfrm(RPI_Weather_Week['snowed']))
desc.snowed
RPI_Weather_Week[desc.snowed,]
######################################

#Creating an empty data frame
empty.DataFrame <- data.frame()
v1 <- 1:10
v1
letters
v2 <- letters[1:10]

df <- data.frame(numbers = v1, letters = v2)
df

#importing data and exporting data
#writing to a CSV file:
write.csv(df,file = '/Users/shlokshah/Spring_21_Semester/Data_Analytics/Lab/Git_Repository/DataAnalytics2021_Shlok_Shah/saved_df1.csv')
df2 <- read.csv('/Users/shlokshah/Spring_21_Semester/Data_Analytics/Lab/Git_Repository/DataAnalytics2021_Shlok_Shah/saved_df1.csv')
df2


###############################################

########## Exercises ##############

grumpData <- read.csv('/Users/shlokshah/Downloads/GPW3_GRUMP_SummaryInformation_2010.csv')
grumpData

library('readxl')
epi2010Data <- read.csv(file.choose(), header = T)
epi2010Data
View(epi2010Data)

fivenum(epi2010Data) #error due to non numeric arguments
fivenum(epi2010Data$PopulationDensity)
boxplot(epi2010Data$PopulationDensity)
hist(epi2010Data$BIODIVERSITY, breaks = 9,
     xlab = 'Biodervisity of EPI 2010 data')

# Filtering NA values for EPI Dataset
attach(epi2010Data)
fix(epi2010Data)
EPI
tf <- is.na(EPI) #True if value is NA
tf

EPI_Filtered <- EPI[!tf]
EPI_Filtered

### Exploring the distribution ##
summary(EPI)
fivenum(EPI,na.rm=TRUE)
