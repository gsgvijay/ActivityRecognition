function [ mat_sum ] = elog_mat_sum( P, Q )
%     disp(size(P));
%     disp(size(Q));
    mat_prod = P.*Q;
%     disp(sum(mat_prod));
    mat_sum = nan;
    for i = 1:length(mat_prod)
        mat_sum = elogsum(mat_sum, mat_prod(i));
    end
end

