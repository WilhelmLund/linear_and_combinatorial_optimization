
% Script for testing the tableau.
A = [1 1 1 0 0;1 0 0 1 0;8 20 0 0 1];
b = [1;3/4;10];
c = [2;1;0;0;0];
basicvars=[3 4 5];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 2a');
disp(basicvars);
tableau
basicvars=[3 1 5];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 2b');
tableau
basicvars=[3 1 2];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 2c');
tableau
