%% Class May 17th
% With found optimal "d" (dimension) (2 in this case), or simply giving a
% lot of possible dimensions (eg. polynomial until 9)
% (1) Plot MSE, variance and mean
% (2) Plot lambda an its associated error


for lambda=linspace(1:2:50)
    dimensions = size(X, 2);
    w = (X'*X+lambda*eye(dimensions))\(X'*Y);
end

% Fer plots de 