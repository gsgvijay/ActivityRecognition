library(zoo)
library(class)
library(caret)
library(plyr)
library(infotheo)

# .dat file paths
data1 <- read.csv("/home/vijay/Downloads/OpportunityUCIDataset/dataset/S2-ADL1.dat", sep=" ", header=F)
data2 <- read.csv("/home/vijay/Downloads/OpportunityUCIDataset/dataset/S2-ADL2.dat", sep=" ", header=F)
data3 <- read.csv("/home/vijay/Downloads/OpportunityUCIDataset/dataset/S2-ADL3.dat", sep=" ", header=F)
data4 <- read.csv("/home/vijay/Downloads/OpportunityUCIDataset/dataset/S2-ADL4.dat", sep=" ", header=F)
data5 <- read.csv("/home/vijay/Downloads/OpportunityUCIDataset/dataset/S2-ADL5.dat", sep=" ", header=F)

# Preprocess the data to remove nulls, interpolate, calculate windows, etc.
preprocess <- function(new_data) {
  data <- new_data[,c(1:34)]
  data <- data[,-c(14,15,16)]
  labels <- new_data[,245]
  for(i in 1:ncol(data)) {
    data[,i] <- na.locf(data[,i])
  }
  data <- data.frame(data, labels)
  counter = 0
  preprocessed <- matrix(0,1,length(data))
  while(counter<max(data[,1])){
    rows = data[data[,1]>= counter & data[,1]<= counter+500,]
    current = sapply(2:length(data)-1, function(i){mean(rows[,i])})
    labelColumn = count(rows[,length(data)])[which.max(count(rows[,length(data)])$freq),1]
    current = cbind(t(current),labelColumn)
    preprocessed = rbind(preprocessed,current)
    counter = counter + 250
  }
  preprocessed
}

# Process the loaded data
nd1 <- preprocess(data1)
nd2 <- preprocess(data2)
nd3 <- preprocess(data3)
nd4 <- preprocess(data4)
nd5 <- preprocess(data5)

# Remove the first column - timestamp because it makes very little sense
# to include timestamp after having averaged it over a 500ms window.
nd1 <- nd1[, 2:ncol(nd1)]
nd2 <- nd2[, 2:ncol(nd2)]
nd3 <- nd3[, 2:ncol(nd3)]
nd4 <- nd4[, 2:ncol(nd4)]
nd5 <- nd5[, 2:ncol(nd5)]

# Combine the testing and training data together
training <- rbind(nd1, nd2, nd3)
labels <- training[,ncol(training)]
training <- training[,-ncol(training)]

testing <- rbind(nd4, nd5)
testing.labels <- testing[, ncol(testing)]
testing <- testing[,-ncol(testing)]

# An empty list to hold the SSE Errors.
sse <- c(2:60)
centers <- c()
for(j in 2:60) {
  km <- kmeans(training, centers = j)
  sse[j-1] = (km$tot.withinss)/j
  # At j=50, the cluster size vs. sse tradeoff value
  if(j == 50) {
    centers <- km$cluster
  }
}
plot(2:60, y = sse, xlab = 'k-value', ylab='SSE', main = 'K-Means: Clusters vs. SSE')
summary(as.factor(centers))
length(centers)
withLabels <- cbind(centers, labels)
withLabels[,1] <- as.factor(withLabels[,1])
withLabels[,2] <- as.factor(withLabels[,2])
summary(withLabels)
# write the binned training data
write.table(x = withLabels, file = "/home/vijay/ActivityMining/ActivityMining/data/NewData/ADL_Train.csv", row.names = F, col.names = F, sep = ",")

km.test <- kmeans(testing, centers = 50)
test.centers <- km.test$cluster
summary(test.centers)
length(test.centers)
new.test <- cbind(test.centers, testing.labels)
# write the binned testing data
write.table(x = new.test, file = "/home/vijay/ActivityMining/ActivityMining/data/NewData/ADL_Test.csv", col.names = F, row.names = F, sep = ",")
  