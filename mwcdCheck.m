%%% The function mwcdCheck() computes the MWCD estimator for the given dataset.
%%% The default weight function is linear decreasing function

function [T,CM] = mwcdCheck(data)
[N, dim] = size(data);
data = data';

%%% you can set your own weight function
weight = ones(1, N) - ((1:N)-1)/N;
sumWeight = sum(weight);
theBestC = 0;
theBestT = 0;
theBestCR = 1000000000000000;
p = N-2;
s = RandStream('mt19937ar','Seed',0);

for i=1:1000
    ps = randperm(s, N, p);
	A = data(1:dim, ps);
    t = mean(A, 2);
    C = zeros(dim, dim);
    for j=1:p
        C = C + (A(:, j)-t)*(A(:, j)-t)';
    end 
    C = C/p;
    c1= 100000;
    
    while true
        residues = zeros(N, 1);
        C1 = inv(C);
        for j=1:N
            residues(j, 1) = (data(:, j)-t)'*C1*(data(:, j)-t);
        end 
        J = 1:N;
        [kk, I] = sort(abs(residues));
        J(I) = J;
        newWeight = weight(J); 
        for j=1:N
            t = t + data(:, j)*newWeight(j);
        end
        t = t/sumWeight;
        C = zeros(dim, dim);
        for j=1:p
            C = C + (data(:, j)-t)*(data(:, j)-t)'*newWeight(j);
        end 
        C = C/sumWeight;
        c2 = det(C)
        if(c2 < c1)
           c1 = c2;
        else
            if(c2 < theBestCR)
                theBestCR = c2;
                theBestC = C;
                theBestT = t;
            end
            break;
        end
    end
end
CM = theBestC;
T = theBestT;
end