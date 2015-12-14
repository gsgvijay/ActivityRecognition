clear all;
close all;
%[p,A,B] = initialize_parameters('~');
iterations = 100
path1 = '/Users/gadiraju/NCSU-git/ActivityRecognition/data/NewData/ADL_Train.csv';
data = load(path1);
%[p,A,B] = initialize_parameters(data);
numberofValsInSample = floor(length(data)/3);
[dataTraining1,idx1] = datasample(data,numberofValsInSample,1,'Replace',false);
remaining = data(setdiff(1:length(data), idx1),:);
[dataTraining2, idx2] = datasample(remaining,numberofValsInSample,1,'Replace',false); 
dataTraining3 = remaining(setdiff(1:length(remaining), idx2),:);


%First of 3 iterations for 3-fold cross validation
train1 = [dataTraining1; dataTraining2];
[p1,A1,B1] = baum_welch_elog(iterations,train1);
[hidden1,acc1] = viterbi_nolog(dataTraining3,1:6,p1,A1,B1);
%[p1,A1,B1] = training_elog(train1);
%testing = load('~/NCSU-git/ActivityRecognition/data/NewData/ADL_Test.csv');
%[hidden1,accuracy1]= viterbi_nolog(testing,1:6,p1,A1,B1)
 
% Second of 3 iterations for 3-fold cross validation
train2 = [dataTraining2; dataTraining3];
[p2,A2,B2] = baum_welch_elog(iterations,train2);
[hidden2,acc2] = viterbi_nolog(dataTraining1,1:6,p2,A2,B2);
%[p2,A2,B2] = training_elog(train2);

%Third of 3 iterations for 3-fold cross validation
train3 = [dataTraining1; dataTraining3];
[p3,A3,B3] = baum_welch_elog(iterations,train3);
[hidden3,acc3] = viterbi_nolog(dataTraining2,1:6,p3,A3,B3);
%[p3,A3,B3] = training_elog(train3);
%Legacy code
% p = (p1 + p2 + p3)/3;
% A = (A1 + A2 + A3)/3;
% B = (B1 + B2 + B3)/3;

%For current run, this was the best result. If better result for other
%cross validations, change to p2,A2,B2 or p3,A3,B3 accordingly
testing = load('~/NCSU-git/ActivityRecognition/data/NewData/ADL_Test.csv');
[hidden,accuracy1]= viterbi_nolog(testing,1:6,p1,A1,B1);

%Write file to disk
csvwrite('predicted.csv',hidden);