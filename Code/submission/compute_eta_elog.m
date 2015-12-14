function etaV = compute_eta_elog(alphaV, betaV,A,B,data)
[times,states]= size(alphaV);
disp 'Compute eta started';
for t = 1:times-1
    normalized = nan;
    for i = 1:states 
        for j = 1:states
            etaV(t,i,j) = elogproduct(alphaV(t,i),elogproduct(elog(A(i,j)), elogproduct(elog(B(j,data(t+1,1))), betaV(t+1,j))));
            normalized = elogsum(normalized,etaV(t,i,j));
        end
    end
    for i = 1:states
        for j=1:states
            etaV(t,i,j) = elogproduct(etaV(t,i,j),-1*normalized);
        end
    end
end
disp 'Compute eta ended';
end
