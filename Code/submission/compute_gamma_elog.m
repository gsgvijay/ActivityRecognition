function [gammaV] = compute_gamma_elog(alphaV, betaV, etaV)
[times,states]= size(alphaV);
disp 'Compute gamma started';
    
    for t = 1:times-1
        for i = 1:states
            gamma_total = nan;
            for j = 1:states
                gamma_total = elogsum(gamma_total, etaV(t, i, j));
            end
            gammaV(t, i) = gamma_total;
        end
    end
%     for i = 1:times
%         normalized = nan;
%         for j = 1: states
%             gammaV(i,j) = elogproduct(alphaV(i,j),betaV(i,j));
%             normalized = elogsum(normalized,gammaV(i,j));
%         end
%         for j = 1:states
%             gammaV(i,j) = elogproduct(gammaV(i,j), -1*normalized);
%     end
%     end
    disp 'Compute gamma ended';
end