clear all
load fisheriris.mat

Y = zeros(150, 3);
Y(1:50, 1) = 1;
Y(51:100, 2) = 1;
Y(101:150, 3) = 1;
X = ones(150, 6);
X(:, 2) = meas(1:150, 1); 
X(:, 3) = meas(1:150, 2);
scatter(X(1:50, 2), X(1:50, 3)); hold on
scatter(X(51:100, 2), X(51:100, 3)); hold on
scatter(X(101:150, 2), X(101:150, 3)); 
xlabel('Feature');
ylabel('Feature');
legend({'Setosa', 'Versicolor','Virginica'}, 'Location', 'northwest');
hold off

clearvars meas species

theta = ones(6, 3);
tau(1) = 10e-5;
tau(2) = 10e-7;
tau(3) = 10e-7;
for i=1:length(X)
    X(i,4)=X(i,2)^2;
    X(i,5)=X(i,3)^2;
    X(i,6)=X(i,2)*X(i,3);
end
for t=1:3
    dif=10;
    counter=0;
    while max(dif)>0.00001
        [theta(:, t),cost(t),dif]=Theta_calc_III(tau(t),theta(:, t),X,Y(:, t));
        counter=counter+1;
        cost_v(counter, t)=cost(t);
    end
    plot(1:counter,cost_v(1:counter, t));
end

x2_inv=ones(100,1);
X_plot(:,1)=ones(100,1);
X_plot(:,2)=linspace(4,7,100);
X_plot(:,3)=linspace(2,4.5,100);
while difer>0.0001 
    
end