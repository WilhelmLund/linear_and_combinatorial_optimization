
disp('Example 1. p. 281')
c = [7;3;0;0]
A = [2 5 1 0; 8 3 0 1]
b = [30;48]
disp('Stem of tree')
basicvars = [3 4]
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
tableau
basicvars = [3 1]
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
tableau

basicvars = [2 1]
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
tableau
disp('Optimal noninteger solution found. x1 = 4.41... x2 = 4.23... Gives optimum value 43.58 and so an upper bound for ILP is 43.')
disp('We use x1 as a branch variable. x1<= 4 or x1>= 5.')
disp('x1<=4')
A = [A zeros(2,1);1 0 0 0 1]
b = [b;4]
c = [c;0]
basicvars = [1 2 5] % Start with the optimal solution which we had found earlier.
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
feasible
disp('This solution is infeasible since the optimum we had found is outside of the domain.')
disp('The two phase method can be avoided by using the dual')
slackvars = [3 4 5];
[dualA,dualb,dualc] = dualproblem(A,b,c,slackvars);

dualA
dualb
dualc
dualbasicvars = setdiff(1:5,basicvars)
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau
dualbasicvars = [3 5]
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau

disp('Optimal noninteger solution found. Opt. value = -41.2 which means that the optimal value for the primal is')
disp('41.2. An upper bound for this branch is 41.2. Leave this node for now (dangling node)')
disp('Investigate the other branch. x1>= 5')

c = [7;3;0;0;0]
A = [2 5 1 0 0; 8 3 0 1 0;-1 0 0 0 1]
b = [30;48;-5]

disp('Infeasible basic solution (as expected).')
disp('Transfer to dual problem.')

slackvars = [3 4 5];
[dualA,dualb,dualc] = dualproblem(A,b,c,slackvars);

dualA
dualb
dualc

basicvars = [1 2 5] % start with the basic solution that we had found earlier with the new slack variable as an extra
%                     % basic variable
dualbasicvars = setdiff(1:5,basicvars)
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau
disp('Apply the simplex method to this tableau as usual, using checkbasic1')
dualbasicvars = [5 4]
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau

disp('Noninteger optimal solution found for the dual problem which corresponds to optimal value 43 for the primal.')
disp('It is easy to find the corresponding solution of the primal problem:')
basicvars = setdiff(1:5,dualbasicvars)
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
disp('and the tableau for the primal problem is')
tableau

disp('Note that 43>41.2 which was found in the earlier node. This branch seems more promising. Continue with this branch')
disp('and keep the other node as a dangling node. ')
disp('Use x2 as a new branching variable, and split up in the two cases x2<=2 and x2>=3')
disp('x2<=2:')
c = [7;3;0;0;0;0]
A = [2 5 1 0 0 0; 8 3 0 1 0 0;-1 0 0 0 1 0; 0 1 0 0 0 1]
b = [30;48;-5;2]
basicvars = [1 2 3 6]
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
feasible

disp('The solution is infeasible as expected. Use dual.')

dualbasicvars = setdiff(1:6,basicvars)
slackvars = [3 4 5 6]; %original slackvariables + new slack
[dualA,dualb,dualc] = dualproblem(A,b,c,slackvars);

[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau
disp('Simplex method on the dual problem with checkbasic1:')
dualbasicvars = [4 6]
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau

disp('Optimal noninteger solution found. z = 42.75. Leave this as a dangling node.')

disp('Other branch: x2>=3')
c = [7;3;0;0;0;0]
A = [2 5 1 0 0 0; 8 3 0 1 0 0;-1 0 0 0 1 0; 0 -1 0 0 0 1]
b = [30;48;-5;-3]
basicvars = [1 2 3 6]
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
feasible
disp('Infeasible solution as expected. Take dual')
dualbasicvars = setdiff(1:6,basicvars)
slackvars = [3 4 5 6]; %original slackvariables + new slack
[dualA,dualb,dualc] = dualproblem(A,b,c,slackvars);

[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau
disp('Incoming variable is x6, but it is not possible to choose an outgoing variable. The dual problem is unbounded')
disp('This means that the primal problem is infeasible.')
disp('This is a terminal node. Go back to the dangling node corresponding to x2<=2')
disp('Use x1 as a branching variable: x1<=5 or x1>=6.')
disp('x1<=5')
c = [7;3;0;0;0;0;0]
A = [2 5 1 0 0 0 0; 8 3 0 1 0 0 0;-1 0 0 0 1 0 0; 0 1 0 0 0 1 0;1 0 0 0 0 0 1]
b = [30;48;-5;2;5]
basicvars = setdiff(1:7,[4 6]);
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
feasible % just checking :) We need to use the dual of course

dualbasicvars = setdiff(1:7,basicvars)
slackvars = [3 4 5 6 7]; %original slackvariables + new slack
[dualA,dualb,dualc] = dualproblem(A,b,c,slackvars);
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau
disp('Simplex method on the dual problem')
dualbasicvars = [6 7]
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau
disp('We cannot choose an incoming variable. This is an integer optimal solution! But only for this branch!')
basicvars = setdiff(1:7,[6 7])
disp('Here is the tableau for the primal problem')
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
tableau

disp('We still need to examine x1>= 6')

c = [7;3;0;0;0;0;0]
A = [2 5 1 0 0 0 0; 8 3 0 1 0 0 0;-1 0 0 0 1 0 0; 0 1 0 0 0 1 0;-1 0 0 0 0 0 1]
b = [30;48;-5;2;-6]
basicvars = setdiff(1:7,[4 6]);
[tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
feasible % go to primal

dualbasicvars = setdiff(1:7,basicvars)
slackvars = [3 4 5 6 7]; %original slackvariables + new slack
[dualA,dualb,dualc] = dualproblem(A,b,c,slackvars);
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau
disp('Simplex method on the dual problem')
dualbasicvars = [4 7]
[dualtableau,y,dualbasic,dualfeasible,dualoptimal] = checkbasic1(dualA,dualb,dualc,dualbasicvars);
dualtableau

disp('Optimal integer solution is found for this branch. It has value 42 which is the highest so far.')
%
disp('Look at other dangling branches. We have only one. The LP problem has value 41.2 < 42. No need to look at this branch. It is cut off.')

% disp('We can use the same method for Example 1. p. 265 using Branch and bound instead of the cutting plane method that was used for this problem in Lecture 5')
% disp('Stem of tree')
% c = [5;6;0;0]
% A = [10 3 1 0;2 3 0 1]
% b = [52;18]
% basicvars = [3 4]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% basicvars = [1 4]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% basicvars = [1 2]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% disp('Branch on x1 (x1<=4 or x1>= 5)')
% disp('x1<=4:')
% A = [A zeros(2,1);1 0 0 0 1]
% b = [b;4]
% c = [c;0]
% basicvars = [3 4 5]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% basicvars = [3 4 1]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% basicvars = [3 2 1]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% disp('integer optimum in this branch found. This branch ends here. Opt. value 40. Keep a note of this number for comparison.')
% disp('Branch x1>=5:')
% A = [10 3 1 0 0; 2 3 0 1 0;1 0 0 0 -1]
% b = [52;18;5]
% basicvars = [3 4 1]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% basicvars = [2 4 1]
% [tableau,x,basic,feasible,optimal] = checkbasic1(A,b,c,basicvars);
% tableau
% disp('Noninteger optimal solution found with z=29. This branch cannot contain the optimum since 29<40 (=previous integer optimum found in side branch)')
% disp('The branch is cut off here.')
%
% disp('Optimal solution found for the full ILP problem. The value if 40.')
