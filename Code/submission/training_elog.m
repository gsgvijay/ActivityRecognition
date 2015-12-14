function [pie,A,B,data,states,features] = training_elog(data)

%path_to_dat = 'data\ADL-1.csv';

    %data = load(path_to_dat);
    %data2 = load(path_to_dat2);
%    data = [data; data2];
    [timestamps,features] = size(data) ;
    features = features-1;
    states = 6;
    labels = [0 101 102 103 104 105];
    noObservations = max(data(:,1));
    % three hyperparameters - pie, A and B
    %compute pie
    for i = 1: states
        pie(i) =  sum(data(:,features+1) == labels(i))/timestamps;
    end
    %Compute A
    % A_initial = randi(10,6,6);
    %  for i = 1:6
    %  A(i,:) = A_initial(i,:) /sum(A_initial(i,:));
    %  end
    A = ones(states,states);
    
    % Compute A
    for i = 1:states
        for j = 1:states
            count = 0;
            for k= 2:timestamps
                if data(k,features+1) == labels(i)
                    if data(k-1, features+1) == labels(j)
                        count = count + 1;
                    end
                end
            end
            A(i, j) = count/sum(data(:, features+1) == labels(i));
        end
    end
    
    % Compute B
    for i = 1:states
        for j = 1:noObservations
            count = 0;
            for k = 1:timestamps
                %B(i,j) = elogproduct(elog(B(i,j)),compute_marginal(i,j,k,data));
                if((data(k,1) == j) && (data(k,2)==labels(i)))
                    count = count+1;
                end
            end
            B(i,j) = count/sum(data(:,2)==labels(i));
        end
    end

    
end