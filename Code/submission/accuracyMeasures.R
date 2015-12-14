#install.packages('zoo')
library(zoo)
library(class)
library(caret)
library(plyr)
library(infotheo)

data  <- read.csv('~/NCSU-git/ActivityRecognition/data/NewData/ADL_Test.csv',header=F)
predicted <- read.csv('~/NCSU-git/ActivityRecognition/predicted.csv',header=F)

actual = as.factor(data[,2])
predicted = as.factor(predicted$V1)


tab = table(predicted,actual)
total = c(1:6)
for(i in 1:6){
total[i] = sum(tab[,i])
}

totalPred = c(1:nrow(tab))
for(i in 1:nrow(tab)){ #Change to 6
    totalPred[i] = sum(tab[i,])    
}

precision0 = tab[1,1]/totalPred[1]
precision101 = tab[2,2]/totalPred[2]
precision102 = tab[3,3]/totalPred[3]
precision103 = 0#tab[4,4]/totalPred[4]
precision104 = 0 #tab[5,5]/totalPred[5]
precision105 = 0 #tab[6,6]/totalPred[6]

recall0 = tab[1,1]/total[1]
recall101 = tab[2,2]/total[2]
recall102 = tab[2,3]/total[3]
recall103 = 0#tab[4,4]/total[4]
recall104 = 0 #tab[5,5]/total[5]
recall105 = 0 #tab[5,5]/total[5]

labels = c(0,101,102,103,104,105)
counts = c(1:6)
weights = c(1:6)
for(i in 1:6){
    counts[i] = sum(predicted == labels[i])   
    weights[i] = counts[i]/length(predicted)
}

weighted_F_measure = weights[1]*(precision0*recall0)/(precision0+recall0) + 
                        #weights[2]*(precision101*recall101)/(precision101+recall101)
                        #+weights[3]*(precision102*recall102)/(precision102+recall102)
                        #+ weights[4]*(precision103*recall103)/(precision103+recall103)
                        #+ weights[5]*(precision104*recall104)/(precision104+recall104)+
                         weights[6]*(precision105*recall105)/(precision105+recall105)

