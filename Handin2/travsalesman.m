function [x,fopt]=travsalesman(D)

[N,M]=size(D);
minmax=zeros(N,2);
for iii=1:N
    minmax(iii,1)=min(D([1:(iii-1) (iii+1):N],iii));
    minmax(iii,2)=max(D([1:(iii-1) (iii+1):N],iii));
end

startx=1;
bounds=boundy(startx,D,minmax);
[x,fopt]=branchandbound(startx,D,minmax,bounds(2));