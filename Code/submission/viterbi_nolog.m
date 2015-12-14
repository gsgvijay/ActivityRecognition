function [ hidden,accuracy ] = viterbi_nolog( observations1, states, pye, A, B )
    %clear all;
    %[pye,A,B] = training_crossValidated();
    %observations1 = load(observationsPath);
    %observations2 = load('~/NCSU-git/ActivityRecognition/data/NewData/ADL5.csv');
    %observations2 = load('~/NCSU-git/ActivityRecognition/data/NewData/ADL5.csv');
    %observations1 = [observations1; observations2]
    [blah1,blah2]= size(observations1);
    observations = observations1(:,1:blah2-1); 
    states= 1:6;
    V = zeros(length(observations)+1, length(states));
    %state = 0;
    %path = zeros(length(states), length(states));
    %hidden = -1*ones(1,length(observations));
    actual = observations1(:,blah2);
    
    % For time, t=0
    for y = states
        V(1, y) = pye(y)*B(y,observations(1,1));
        path(y) = y;
    end
    % For other times
    for t = 2:length(observations)
%         newPath = -1(, length(states));
        for y = 1:6
            prob = 0;
            for z = 1:6
                newProb = V(t-1, z)* A(z, y)* B(y, observations(t));
                if(newProb > prob)
                    prob = newProb;
                    state = z;
                end
            end
            V(t,y) = prob;
            newPath(y) = state;
            %hidden(t) = state;
        end
        path(t,:) = newPath;
    end
    
    %Compute which v has max value at time stamp t
    [probability,bestState] = max(V(length(observations),:));
    %pathFollowed = path(state);
    hidden = path(:,bestState);
    %Compute accuracy
    actualStates = [0 101 102 103 104 105];
     for l = 1:6
         hidden(hidden==l) = actualStates(l);
     end
     accuracy = sum(hidden(:) == actual(:))/length(hidden);
%end

