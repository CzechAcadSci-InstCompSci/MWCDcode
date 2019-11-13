%%% Computation of the minimum weighted covariance determinant estimator (MWCD).
%%% This is the main file. 
%%% The input data file has to fulfil:
%%% - format *.txt
%%% - individual observations in rows
%%% - values separated by spaces
%%% - the first column corresponds to the index of the observation (i=1,...,n)
%%% - e.g. 2 5 5 5 in the input file corresponds to the second observation equal to (5,5,5) 
%%% - we assume the data matrix to be regular

clear all;

canContinue = false;
while(~canContinue) 
    try
        inputData = input('Please enter the name of the data file: ','s');
        data = load(inputData);
    catch
        'Error in reading the data file, please try again.'
        continue;
    end
    [N, dim] = size(data);
    
    if(prod(svd(data)) ~= 0)
        canContinue = true;
    else
        'The requirement of regularity of the data matrix is violated!!!'
    end
end
curX = 2;
curY = 3;
dim = dim-1;
data = data(:, 2:dim);
'T ... mean; C ... covarience matrix'
[T, C] = mwcdCheck(data)

%(X-T)TC(X-T) = CONST
CONST = 5;
C = inv(C);
[V,D] = eigs(C);

Nfit = 100;
fi = linspace(0, 2*pi, Nfit);
y1 = sqrt(CONST/D(curX,curX))*cos(fi);
y2 = sqrt(CONST/D(curY,curY))*sin(fi);
y = [y1; y2]
mwcdFit = repmat(T, 1, Nfit)+ V(:,[curX,curY])*y;

[T, C] = mwcd(data, 1);
%(X-T)TC(X-T) = CONST
CONST = 5;
C = inv(C);
[V,D] = eigs(C)

Nfit = 100;
fi = linspace(0, 2*pi, Nfit);
y1 = sqrt(CONST/D(curX,curX))*cos(fi);
y2 = sqrt(CONST/D(curY,curY))*sin(fi);
y = [y1; y2]
classFit = repmat(T, 1, Nfit)+ V(:,[curX,curY])*y;

% pom = sqrt(-4*C(1,1)*CONST/((C(2,1)+C(1,2))^2 - 4*C(1,1)*C(2,2)))
% mwcdFitX = linspace(T(2)-pom,T(2)+pom,100);
% mwcdFitY1 = (-(C(2,1)+C(1,2)*(mwcdFitX - T(1)) - sqrt(((C(2,1)+C(1,2))^2)*(mwcdFitX - T(1)).^2 - 4*C(1,1)*(C(2,2)*((mwcdFitX - T(1)).^2)-CONST))))/(2*C(1,1))+T(1);
% mwcdFitY2 = (-(C(2,1)+C(1,2)*(mwcdFitX - T(1)) + sqrt(((C(2,1)+C(1,2))^2)*(mwcdFitX - T(1)).^2 - 4*C(1,1)*(C(2,2)*((mwcdFitX - T(1)).^2)-CONST))))/(2*C(1,1))+T(1);

options.intercept = 0;
options.alpha = 0.75;
options.ntrial = 500;
%[sig,mu] = fastmcd(data, options)
%[mcdV,mcdD] = eigs(sig.cov);
% mcdy = [sqrt(CONST/mcdD(1,1))*cos(fi); sqrt(CONST/mcdD(2,2))*sin(fi)];
% mcdFit = repmat(sig.center', 1, Nfit)+ mcdV*mcdy;

hold on;
data = data';
scatter(data(2, :),data(1, :));
plot(mwcdFit(2, :), mwcdFit(1, :), 'color', 'black');
plot(classFit(2, :), classFit(1, :), 'color', 'green');
legend('body', 'MWCD', 'Klasický odhad');
xlabel('x_2');
ylabel('x_3');
myboldify;
% plot(mcdFit(2, :), mcdFit(1, :), 'gx');
% plot(mwcdFitX, mwcdFitY1);
% plot(mwcdFitX, mwcdFitY2);
hold off;

