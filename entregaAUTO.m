clear all;
clc;
load carsmall.mat
clear Cylinders Displacement Mfg Model Model_Year MPG Acceleration Origin

%% Part 1
for i = 1:5 %% Cross validation loop
    val = randperm(length(Weight),20);
    Horsepower(77) = 80;
    XY = [Weight(val),Horsepower(val)];
    x_test = XY(:,1);
    y_test = XY(:,2);
    val2 = setdiff(1:length(Weight),val);
    XY2 = [Weight(val2),Horsepower(val2)];
    y_train = XY2(:,2);
    x_train = XY2(:,1);
    figure(i)
    scatter(x_train,y_train);
    hold on
    scatter(x_test,y_test,'red');
    for k = 1:5 %% Polynomical degree loop
        X_train = ones(length(x_train),k+1);
        Y_train = ones(length(y_train),k+1);
        X_test = ones(length(x_test),k+1);
        Y_train = ones(length(y_train),k+1);
        for j = 2:size(X_train,2)
            X_train(:,j) = x_train.^(j-1);
            Y_train(:,j) = y_train.^(j-1);
        end
        for j = 2:size(X_test,2)
            X_test(:,j) = x_test.^(j-1);
            Y_test(:,j) = y_test.^(j-1);
        end
        w = X_train\y_train;
        Y_reg = X_train * w;
        pl = sortrows([x_train,Y_reg]);
        plot(pl(:,1),pl(:,2));
        MSE_train(i,k) = (1/(length(x_train))*sum((Y_reg - y_train).^2));
        Y_regTest = X_test * w;
        MSE_test(i,k) = (1/(length(x_train))*sum((Y_regTest - y_test).^2));
        GenError(i,k) = abs(MSE_train(i,k) - MSE_test(i,k));
    end
    hold off
    xlabel("Weight");
    ylabel("Horsepower");

end
for k =1:5
    MSE_testAV(k) = mean(MSE_test(:,k));
    MSE_trainAV(k) = mean(MSE_train(:,k));
    GenErrorAv(k) = mean(GenError(:,k));
end
figure(6)
barplotAV = [MSE_testAV;MSE_trainAV];
d = linspace(1,5,5);
bar(d,barplotAV)
xlabel("Degree of polynomial regression");
ylabel("Error (absolute)");
legend("MSE train", "MSE test");

% Plot variància i mitjana

%% Part 2
A = X_train;
b = y_train;

% L1 Norm
[n, m] = size(A);
X  = linprog([zeros(m, 1); ones(n, 1)],[A, -eye(n); -A, -eye(n)], [b; -b]);
X1 = X(1:m);
y1 = A*X1;
scatter(A(:, 2),b); hold on
scatter(X_test(:, 2),y_test); hold on
pl = sortrows([A(:, 2),y1]);
plot(pl(:,1),pl(:,2), linewidth=2);
xlabel("Weight");
ylabel("Horsepower");
title('L1');
hold off
MSE_train_L1 = (1/(length(A))*sum((y1 - y_train).^2));

% Linfty norm
f = [zeros(m, 1); 1];
Ane = [A, -ones(n, 1); -A, -ones(n, 1)];
bne = [b; -b];
X = linprog(f, Ane, bne);
Xinfty = X(1:m, :);
figure()
yinfty = A*Xinfty;
scatter(A(:, 2),b); hold on
scatter(X_test(:, 2),y_test); hold on
pl = sortrows([A(:, 2),yinfty]);
plot(pl(:,1),pl(:,2), linewidth=2);
xlabel("Weight");
ylabel("Horsepower");
title('Linfty');
hold off

MSE_train_L1inf = (1/(length(A))*sum((yinfty - y_train).^2));