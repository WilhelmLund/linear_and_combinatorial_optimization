function [tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
% [x,basic,optimal,feasible]=checkbasic1(A,b,c,basicvars),
% INPUT:    A - mxn matrix
%           b - mx1 matrix
%           c - nx1 matrix
%           basicvars - list of m indices between 1 and n.
% OUTPUT:
%   tableau     - the (m+1) x (n+1) matrix representing the simplex tableau
%               (skip the column corresponding to the objective function z)
%   x           - nx1 matrix. The basic solution corresponding
%               to basic variables basicvars.
%   basic       - 1 if x is a basic solution
%   optimal     - 1 if x is an optimal solution
%   feasible    - 1 if x is a feasible solution
% to the LP-problem in canonical form
% max z = c’*x
% subject to A*x=b, x>=0

m = size(A, 1);
n = size(A, 2);

nonbasic = setdiff(1:size(A,2), basicvars);

Ab = A(:,basicvars);
An = A(:,nonbasic);
%Ab = A(:,n-m+1:end);
%An = A(:,1:n-m);


cb = c(basicvars);
cn = c(nonbasic);
%cb = c(n-m+1:end);
%cn = c(1:n-m);

tableau = [inv(Ab)*An eye(m) inv(Ab)*b; cb'*inv(Ab)*An-cn' zeros(1,m) cb'*inv(Ab)*b];
%tableau = tableau(:,[nonbasic basicvars]);

x = [zeros(n-m,1); tableau(1:m,end)];
basic = 1;
feasible = all(x(1:n) >=0);
optimal = all(tableau(end,1:(n-m)) >= 0);
