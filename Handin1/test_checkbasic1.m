%%
%2
% Script for testing the tableau on exercise problems
A = [1 1 1 0 0;1 0 0 1 0;8 20 0 0 1];
b = [1;3/4;10];
c = [2;1;0;0;0];
basicvars=[3 4 5];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 2a');
tableau
basicvars=[3 1 5];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 2b');
tableau
basicvars=[3 1 2];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 2c');
tableau

%%
%3
% Script for testing the tableau.
A = [3 2 1 0 0;5 1 1 1 0;2 5 1 0 1];
b = [1;3;4];
c = [-1;-1;-1;-1;-1]; %(converting min-problem to max-problem)
basicvars=[3 4 5];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 3a');
tableau
basicvars=[2 4 5];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
disp('Problem 3b');
tableau

%%
%4
A=[1 2 2 1 1 0 1 0 0; 1 2 1 1 2 1 0 1 0;3 6 2 1 3 0 0 0 1];
b=[12;18;24];
c=[0; 0; 0; 0; 0; 0; -1; -1; -1];

basicvars=[7 8 9];
[tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
tableau

while(~optimal)
    obj_row = tableau(end, 1:size(A,2));
    ent_var = find(obj_row == min(obj_row));
    ent_var = ent_var(1);
    ratios = tableau(1:end-1, end) ./ tableau(1:end-1, obj_row);
end

% Change to the original problem
A=[1 2 2 1 1 0; 1 2 1 1 2 1 ;3 6 2 1 3 0 ];
c=[1;-2;-3;-1;-1;2];

while(~optimal)
    obj_row = tableau(end, 1:size(A,2));
    ent_var = obj_row == min(obj_row);
    basicvars=[7 8 9];
    [tableau,x,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
    tableau
end