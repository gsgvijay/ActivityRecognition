function elnsum = elogsum(x,y)
if(isnan(x) || isnan(y))
    if(isnan(x))
        elnsum = y;
    else
        elnsum = x;
    end
else
    if(x>y)
        elnsum = x + elog(1 + exp(y-x));
    else
        elnsum = y + elog(1 + exp(x-y));
    end
end
end