function bounds=boundy(x,D,minmax)
% function bounds=boundy(x,D,minmax);
% calculates the 1x2 vector with lower and upper bound
% respectively,
% given the 1xn vector x with the current path,
% the NxN distance matrix D and the Nx2 matrix
% minmax, where minmax(i,1) is the minimum distance
% from city i and minmax(i,2) is the maximum distance
% from city i.
N = size(minmax,1);
undeparted = setdiff(1:N,x(1:end-1));
minmax_undeparted = minmax(undeparted,:);

x_prev = x(1);
dxi = 0;
for i = x(2:end)
    dxi = dxi + D(x_prev,i);
    x_prev = i;
end
if(numel(undeparted) > 1)
    bounds = dxi + sum(minmax_undeparted,1);
else
    bounds = [dxi dxi] + D(undeparted,x(1));
end
%{
bounds = zeros(N,2);
for i = unvisited
    dix = D(x,i);
    bounds(i,:) = dix + sum(minmax_no_x,1);
end
bounds(bounds(:,1) == 0) = inf;
bounds = bounds(bounds(:,2) == min(bounds(:,2)),:);
%}