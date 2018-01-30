function [tableau,x,optimal,basicvars] = simplex(tableau, basicvars)
optimal = 0;
cycles = false;

while(~optimal)
    obj_row = tableau(end, 1:size(tableau,2)-1);
    ent_var = find(obj_row == min(obj_row));
    ent_var = ent_var(end);
    
    ratios = tableau(1:end-1, end) ./ tableau(1:end-1, ent_var);
    
    prow = find(ratios == min(ratios));
    prow = prow(end);
    dep_var = basicvars(prow);
    
    pcol = ent_var;
    
    pivotal_column = tableau(1:end-1,pcol);
    if(~any(pivotal_column >= 0))
        fprintf('no optimum');
        break
    end
    tableau(prow, :) = tableau(prow, :) / tableau(prow, pcol);
    pivotal_row = tableau(prow,:);
    for row = 1:size(tableau,1)
        if(row ~= prow && pivotal_row(pcol))
            k = -tableau(row,pcol)/pivotal_row(pcol);
            tableau(row,:) = tableau(row,:) + pivotal_row*k;
            assert(tableau(row,pcol) == 0);
        end
    end
    dep_index = basicvars == dep_var;
    basicvars(dep_index) = ent_var;
    optimal = all(tableau(end,:) >= 0);
end

x = zeros(size(tableau,2)-1,1);
x(basicvars) = tableau(1:end-1,end);
