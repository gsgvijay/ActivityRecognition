function [alphaV] = compute_forward_elog(pie,A,B,data,states,features) 
% clear all;
% close all;
% path = '~/data/activity/ADL-1.csv';
% [pie,A,B,data] = initialize_parameters(path);
noObservations = max(data(:,1));
disp 'Compute Forward started';
[timestamp,cols] = size(data);
alphaV = zeros(timestamp,states);
%Compute each alpha value
 for i = 1:states 
    alphaV(1,i) = elogproduct(elog(pie(i)) , elog(B(i,data(1,1))));
 end
    for i = 2:timestamp
        for j = 1:states
            %Computing alpha_sum
            alpha_sum = nan;
            %disp(i);
            for k = 1:states
               alpha_sum = elogsum(alpha_sum , elogproduct(alphaV(i-1,k), elog(A(k,j)))); 
               %alpha_sum = elogsum(alpha_sum , alphaV(i-1,k)* elog(A(k,j)));
            end
%                 if(alpha_sum == 0)
%                     alpha(i,j) = -1*log(B(i-1,j));
%                 else
                    alphaV(i,j) = elogproduct(elog(B(j,data(j,1))),alpha_sum);
%                 end
%                 if(alpha(i,j)==0)
%                     disp(i);
%                     disp(j);
%                     disp(alpha(i-1,:));
%                     disp(A(j,:));
%                     br = true;
%                     break;
%                 end
            
        end
%         if(br==true)
%             break;
%         end
        %disp(alpha(i,:));
    end
 disp 'Compute forward ended';
end