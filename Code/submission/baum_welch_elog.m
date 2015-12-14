function [pie,A,B] = baum_welch_elog(num_iter,data)
%path_to_dat = '~/data/activity/ADL-1.csv';
%
%path_to_dat = '/Users/gadiraju/NCSU-git/ActivityRecognition/data/NewData/ADL_Train.csv';
%[pie,A,B,data,states,features] = training_elog(path_to_dat);
[pie,A,B,data,states,features] = initialize_parameters(data);
[timestamp,cols] = size(data);
noObservations = max(data(:,1));
labels = [0 101 102 103 104 105];
% Repeat for num_iter times
disp 'Started';
for i = 1:num_iter
    %Forward step
    %Compute initial for first iteration
    %sprintf('Current iteration = %d',i);
    %disp(i);
    %f(i==1)
    disp(i);
    alphaV= compute_forward_elog(pie,A,B,data,states,features);
    betaV = compute_backward_elog(pie,A,B,data,states,features);
    etaV = compute_eta_elog(alphaV,betaV,A,B,data);
    gammaV = compute_gamma_elog(alphaV,betaV, etaV);

    %disp(gamma);
    %else
    for m=1:states
        pie(m) = eexp(gammaV(1,m));
    end
    for j = 1:states
        for k = 1: states
            numerator = nan;
            denominator = nan;
            for t = 1:timestamp-1
                numerator = elogsum(numerator,etaV(t,j,k));
                 denominator = elogsum(denominator,gammaV(t,j));
            end
            disp(denominator);
            A(j,k) = eexp(elogproduct(numerator,-1*denominator));
            %A(j,k) = elogproduct(numerator,-1*denominator);
        end
    end

%Computed A value
    disp 'New A computed';
 
    for s = 1:states
        for obs = 1:noObservations
             numerator = nan;
             denominator = nan;
             for t = 1:timestamp-1
                if(data(t,1) == obs)
                    numerator = elogsum(numerator,gammaV(t,s));
                end
                denominator = elogsum(denominator, gammaV(t,s));
             end
            B(s,obs) = eexp(elogproduct(numerator, -1*denominator));
        end
   end
    
            %                 disp(numerator);
            %                 disp(sum(P));
            %                 for t = 1:times
            %                     if(isequal(data(j,1:cols-1), data(t,1:cols-1)))
            %                         numerator = elogsum(numerator,gammaV(t,i));
            %                     end
            %                     denominator = elogsum(denominator,gammaV(t,i));
            %                 end
%             B(j,k) = eexp(elogproduct(numerator,-1*denominator(k)));
 disp 'New B computed';
    %alpha(1,i) = 1; %Scaled using scale factor
    disp 'iteration completed';
%        
end
end
%end
%end
%