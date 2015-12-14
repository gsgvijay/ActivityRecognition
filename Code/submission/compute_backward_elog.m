function betaV = compute_backward_elog(pie,A,B,data,states,features)
%clear all;
%close all;
% %%Testing code
 %path = 'data\ADL-1.csv';
 %[pie,A,B,data] = initialize_parameters(path);
% %%
noObservations = max(data(:,1));
[timestamp,cols] = size(data);
betaV = zeros(timestamp,6);
for i = 1:6
   betaV(timestamp,i) = 0; 
end

%Compute all other beta values
for i = timestamp-1:-1:1
    for j = 1:states
%         beta_t_j = exp(-1*beta(i+1,:));
%         disp(beta_t_j)
%         a_j_k = A(j,:);
% %         disp(a_j_k)
%         b_t_j = B(i+1,:);
%         prods = beta_t_j.*a_j_k.* b_t_j;
%         disp(j)
%         disp(prods)
%         %disp(i);
%         %disp(j);
%         %disp(prods);
%         tmpSum = tmpSum+ prods;
%         %disp(tmpSum);
        %For each beta_i, get all its corresp beta_j 
        logbeta = nan;
        for k = 1:states
            logbeta = elogsum(logbeta, elogproduct(elog(A(j,k)),elogproduct(elog(B(k,data(i+1,1))),betaV(i+1,k))));
        end
%         if(tmpSum==0)
%              beta(i,j) = 0;
%         else
        betaV(i,j) = logbeta;
%         end
    end
%     if(sum==0)
%             disp('Sum as zero');
%             disp(i)
%             disp(j)
%             break;
%     end
    %disp(beta(i,:));
end
%end