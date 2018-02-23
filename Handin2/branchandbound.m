function [x,fopt]=branchandbound(x,D,minmax,fopt)
[N,M]=size(D);
bounds=boundy(x,D,minmax);
if bounds(1)==bounds(2)
    if bounds(1)<fopt
        fopt=bounds(1);
    end
else
    X=branchy(x,N);
    nn=size(X,1);
    B=zeros(nn,2);
    for iii=1:nn
        B(iii,:)=boundy(X(iii,:),D,minmax);
        %fprintf("branch: \n");
        %for xx = X(iii,:)
        %    fprintf("%i ",xx);
        %end
        %fprintf("\nwith bounds: \n");
        %for bb = B(iii,:)
        %    fprintf("%i ",bb);
        %end
        %fprintf("\n\n");
    end
    [B,ordo]=sortrows(B);
    X=X(ordo,:);
    for iii=1:nn
        if B(iii,1)<fopt
            [x_new,fopt_new]=branchandbound(X(iii,:),D,minmax,fopt);
            if fopt_new<fopt
                fopt=fopt_new;
                x=x_new;
            end
        end
    end
end
