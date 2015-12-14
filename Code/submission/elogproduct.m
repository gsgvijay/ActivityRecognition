function elnproduct = elogproduct(x,y)
if(isnan(x) || isnan(y))
    elnproduct = nan;
else
    elnproduct = x + y;
end
end