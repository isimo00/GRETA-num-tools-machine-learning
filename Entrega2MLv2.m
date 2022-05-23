clear all;
clc;
load carsmall.mat
clear Cylinders Displacement Mfg Model Model_Year MPG Acceleration Origin

for i=1:5
val = randperm(length(Weight),20);
Horsepower(77) = 80;
XY = [Weight(val),Horsepower(val)]
x_test = XY(:,1);
y_test = XY(:,2);
val2 = setdiff(1:length(Weight),val);
XY2 = [Weight(val2),Horsepower(val2)];
y_train = XY2(:,1);
x_train = XY2(:,2);


%% Plot 1 Linear Regression
figure(1)
scatter(x_train,y_train);
hold on
xlabel('Weight');
ylabel('Horsepower');
wLinear = x_train\y_train;
yLinear = wLinear*x_train;
plot(x_train,yLinear);
hold off

%% Plot 2 Fine Regression
figure(2)
xFine = [ones(length(x_train),1),x_train];
xFine_test = [ones(length(x_test),1),x_test];
wFine = xFine\y_train;
yFine = xFine * wFine;
scatter(x_train,y_train);
hold on
xlabel('Weight');
ylabel('Horsepower');
plot(xFine,yFine);
hold off

%% Plot 3 Quadratic Regression
figure(3)
xQuad = [ones(length(x_train),1),x_train,x_train.^2];
xQuad_test = [ones(length(x_test),1),x_test,x_test.^2];
wQuad = xQuad\y_train;
yQuad = xQuad * wQuad;
scatter(x_train,y_train);
hold on
xlabel('Weight');
ylabel('Horsepower');
pl = sortrows([x_train,yQuad])
plot(pl(:,1),pl(:,2));
hold off

%% Error calculation Linear Regresion

MSElin_train(i) = (1/(length(x_train))*sum((y_train -  yLinear).^2));
yLinear_test = wLinear * x_test;
MSElin_test(i) = (1/(length(x_test))*sum((y_test - yLinear_test).^2));
GenError_Linear(i) = abs(MSElin_train(i) - MSElin_test(i));

%% Error calculation Fine Regresion

MSEfine(i) = (1/(length(x_train))*sum((y_train-yFine).^2));
yFine_test = xFine_test * wFine;
MSEfine_test(i) = (1/(length(x_test))*sum((y_test - yFine_test).^2));
GenError_Fine(i) = abs(MSEfine(i) - MSEfine_test(i));

%% Error calculation Quadratic Regresion
para1 = sum(abs(y_train-yQuad)); % coses meves
para2 = sum(abs(y_train-yFine)); % coses meves
MSEquad(i) =(1/(length(x_train))*sum((y_train - yQuad).^2));
yQuad_test = xQuad_test * wQuad;
MSEquad_test(i) = (1/(length(x_test))*sum((y_test - yQuad_test).^2));
GenError_Quad(i) = abs(MSEquad(i) - MSEquad_test(i));
end
figure(4)
it = linspace(1,5,5);
barplot = [MSElin_train;MSElin_test;MSEfine;MSEfine_test;MSEquad;MSEquad_test]
bar(it,barplot)
figure(5)
barplot2 = [GenError_Linear;GenError_Fine;GenError_Quad];
bar(it,barplot2)
GenErrorAV_Linear = mean(GenError_Linear)
GenErrorAV_Fine = mean(GenError_Fine)
GenErrorAV_Quad = mean(GenError_Quad)

%% 10 de maig
R = zeros(4);
y_pred = zeros(length(x), 1);
for d=1:4
    w(d) = ((x.^d)'*x.^d)\((x.^d)'*y);
    y_pred = y_pred + w(d)*x.^d;
    MSE_d(d) = 1/length(x)*sum((y_pred-y).^2);
end
% dona inversa la relació (creix el MSE i no sé pk, m'ho tronaré a mirar)
