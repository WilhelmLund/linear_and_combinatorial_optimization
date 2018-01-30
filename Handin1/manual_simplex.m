function [tableau,x,optimal,basicvars] = manual_simplex(tableau, basicvars, ent, dep)
optimal = 0;
     
prow = find(dep == basicvars);    
prow = prow(end);
        
pcol = ent;
        
pivotal_column = tableau(1:end-1,pcol);    
if(~any(pivotal_column >= 0))
    frpintf('no optimum');
    return;
end
tableau(prow, :) = tableau(prow, :) / tableau(prow, pcol);
pivotal_row = tableau(prow,:);
for row = 1:size(tableau,1)
    if(row ~= prow && pivotal_row(pcol))
        k = -tableau(row,pcol)/pivotal_row(pcol);
        tableau(row,:)  = tableau(row,:) + pivotal_row*k;
        assert(tableau(row,pcol) == 0);
    end
end
dep_index = basicvars == dep;
basicvars(dep_index) = ent;
optimal = all(tableau(end,:) >= 0);


x = zeros(size(tableau,2)-1,1);
x(basicvars) = tableau(1:end-1,end);
