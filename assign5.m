clear all
load fisheriris.mat

Y = zeros(100, 1);
Y(51:100, 1) = 1;
X = ones(100, 3);
X(:, 2) = meas(1:100, 1); 
X(:, 3) = meas(1:100, 2);
scatter(X(1:50, 2), X(1:50, 3)); hold on
scatter(X(51:100, 2), X(51:100, 3)); 
xlabel('Feature 1');
ylabel('Feature 2');
legend('Setosa', 'Versicolor', location='northwest');
hold off

clearvars meas species

theta = ones(3, 1);
px = zeros(length(X), 3);
derivJ = zeros(length(X), 1);
tau = 10e-5;
derivJ = zeros(3, 1);

count =0;
while (derivJ > 0.001 | derivJ == 0)
    for i=1:length(X)
        h_theta = X*theta;
        px = exp(h_theta)./(1+exp(h_theta)); % Using logistic function
    end
    
    for i=1:length(X)
        derivJ(i) = derivJ - (px(i)-Y(i))*X;
    end
    theta_current(:) = theta_current(:) - tau*derivJ(:);
    J %cost
    count = count +1;
end