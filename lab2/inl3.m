COST_MAX = 1e5;

%Problem utan rabatt
s = [100 120 60]';
d = [50 40 90 70 30]';
c = [11 COST_MAX 8 8 0; 7 5 6 12 0; 7 6 8 5 0];

[x,cost]=transport(s,d,c);
disp("x: ");
disp(x);
disp("cost without discount " + cost(end));

s = [80 120 60 20]';
d = [50 40 90 70 30]';
c = [11 COST_MAX 8 5 0; 7 5 6 12 0; 7 6 8 5 0; COST_MAX COST_MAX COST_MAX 8 COST_MAX];

[x,cost]=transport(s,d,c);
disp("x: ");
disp(x);
disp("cost with discount " + cost(end));