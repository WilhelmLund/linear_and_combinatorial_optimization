travsalesmandata;
[x2,fopt2] = travsalesman(D);
D = [0 180 240 500 550 550 280;...
    180 0 140 350 450 500 280;...
    240 140 0 350 600 650 400;...
    500 350 350 0 220 290 350;...
    550 450 600 220 0 90 250;...
    550 500 650 290 90 0 350;...
    280 280 400 350 250 350 0];
%D = [0 6 13 3; 6 0 6 9; 13 6 0 4; 3 9 4 0];
Nmax = 7;
nsamples = 10;

%%{
t = zeros(Nmax,nsamples);
for N = 2:Nmax
    for j = 1:nsamples
        D = rand_world(N);
        tic
        [x,fopt] = travsalesman(D);
        t(N,j) = toc;
    end
end
%}

I = zeros(Nmax,2);
q = norminv(0.975,0,1);
tau_N = zeros(Nmax-1,1);
width = zeros(Nmax-1,1);
for i = 1:Nmax-1
    tau_N(i) = mean(t(i,:));
    sigma = var(t(i,:));
    I(i,:) = tau_N(i) + [-q*sigma/sqrt(N) q*sigma/sqrt(N)];
    width(i) = q*sigma/sqrt(nsamples);
end

function D = rand_world(N)
    D = zeros(N,N);
    for i = 1:N
        for j = 1+i:N
            %subdiagonal
            if(i > 1)
                d = max(0,D(i-1,j)-D(i-1,j-1))+randi([1 10]);
                D(i,j) = d;
                D(j,i) = d;
            else
                D(i,j) = randi([1 10]);
                D(j,i) = D(i,j);
            end
        end
    end
end

