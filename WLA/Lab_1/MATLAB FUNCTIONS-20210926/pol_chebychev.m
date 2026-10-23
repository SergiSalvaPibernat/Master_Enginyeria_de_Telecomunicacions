function a=pol_chebychev(N)

if (N==0)
    a=[1];
end

if (N==1)
    a=[1 0];
end

if (N>1)
    a=conv(pol_chebychev(N-1),[2 0]) - [0 0 pol_chebychev(N-2)];
end
    