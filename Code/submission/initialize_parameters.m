function [pie,A,B,data,states,features] = initialize_parameters(data)
%path = 'data\ADL-1.csv';
%clear all;
%path_to_dat = 'data\ADL-1.csv';

%path2 = '/Users/gadiraju/NCSU-git/ActivityRecognition/data/NewData/ADL2.csv';
%path3 = '/Users/gadiraju/NCSU-git/ActivityRecognition/data/NewData/ADL3.csv';
%data = load(path1);
%data2 = load(path2);
%data3 = load(path3);
%data = [data;data2;data3]; 
[timestamp,features] = size(data) ;
features = features-1;
states = 6;
% three hyperparameters - pie, A and B
%compute pie
labels = [0 101 102 103 104 105];
noObservations = max(data(:,1));
for i = 1: states
    pie(i) =  sum(data(:,features+1) == labels(i))/timestamp;
end
%Compute A (normal random variable being used for now)
 A_initial = randi(10,6,6);
  for i = 1:6
  A(i,:) = A_initial(i,:) /sum(A_initial(i,:));
  end
% A = ones(states,states);
% A=  spdiags (sum (abs(A),2), 0, states, states) \ A;
    % Compute A
    
%     for i = 1:states
%         for j = 1:states
%             count = 0;
%             for k= 2:timestamp
%                 if data(k,features+1) == labels(i)
%                     if data(k-1, features+1) == labels(j)
%                         count = count + 1;
%                     end
%                 end
%             end
%             A(i, j) = elog(count/sum(data(:, features+1) == labels(i)));
%         end
%     end
%B normal random variable with 6 cols and  6816 rows
   B_initial= randi(10,states,noObservations);
   for i = 1:states
   B(i,:) = B_initial(i,:)/ sum(B_initial(i,:));
   end
%  B = ones(states,noObservations);
%  for i= 1:6
%    B(i,:) = B(i,:)/sum(B(i,:));
% end

% Compute B
%     for j = 1:states
%         for k = 1:noObservations
%             B(j,k) = 1
%             for l = 1:features
%                 %B(i,j) = elogproduct(elog(B(i,j)),compute_marginal(i,j,k,data));
%                 B(j,k) = B(j,k)*sum((data(:,l)==k)& (data(:,features+1)==labels(j)))/(sum(data(:,features+1)==labels(j)));
%             end
%             %B(j,k) = elogproduct_mat(marginal_B);
%         end
%     end

%bsxfun(@rdivide,B,sqrt(sum(B.^2,2)));
%Source: https://www.mathworks.com/matlabcentral/newsreader/view_thread/160991
%
end