help("read.csv")


data1 <- read.csv(file.choose(), header = T)

boxplot(data1$EPI)
summary(data1$EPI)
summary(data1)

plot(data1$Population07)
