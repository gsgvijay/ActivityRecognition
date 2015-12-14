function elnproduct = elogproduct_mat(x)
    elnproduct =x(1) ;
    for i = 2:length(x)
      if(isnan(x(i))~=1)  
        elnproduct = elnproduct + x(i);
      end
    end
end