function X=branchy(x,N)
% function X=branchy(x,N);
% returns the mx(n+1) matrix X where
% each row of X is a possible extension
% of the input path x.
% x is a 1xn vector, and N is the total number
% of cities in the problem.

unvisited = setdiff(1:N,x)';
m = numel(unvisited);
X = [repmat(x,m,1) unvisited];