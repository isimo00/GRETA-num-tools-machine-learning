clear all
load fisheriris.mat

Y = zeros(100, 1);
Y(51:100, 1) = 1;
X = ones(100, 3);
X(:, 2) = meas(1:100, 1); 
X(:, 3) = meas(1:100, 2);
xlabel('Feature 1');
ylabel('Feature 2');
legend('Setosa', 'Versicolor', location='northwest');
hold off

clearvars meas species

theta = ones(3, 1);
tau = 10e-5;

% while (derivJ > 0.001 | derivJ == 0)
%     for i=1:length(X)
%         thetax1 = theta_current(1)*X(i, 1);
%         thetax2 = theta_current(2)*X(i, 2);
%         thetax3 = theta_current(3)*X(i, 3);
%         px(i, 1) = px(i, 1) + exp(thetax1)/(1+exp(thetax1)); % Using logistic function
%         px(i, 2) = px(i, 2) + exp(thetax2)/(1+exp(thetax2)); % Using logistic function
%         px(i, 3) = px(i, 3) + exp(thetax3)/(1+exp(thetax3)); % Using logistic function
%     end
%     
%     for i=1:length(X)
%         derivJ(1) = derivJ(1) - (px(i, 1)-Y(i))*X(i);
%         derivJ(2) = derivJ(2) - (px(i, 2)-Y(i))*X(i);
%         derivJ(3) = derivJ(3) - (px(i, 3)-Y(i))*X(i);
%     end
%     theta_current(:) = theta_current(:) - tau*derivJ(:);
% end

% h_theta=X*theta;
% p_x=exp(h_theta)./(1+(exp(h_theta)));
% sum_J=0;
% for i=1:length(X)
%    J=(-Y(i,1)*log(p_x(i,1))-(1-Y(i,1)*log(1-p_x(i,1))));
%    sum_J=sum_J+J;
% end
% sum_derivJ0=0;
% sum_derivJ1=0;
% sum_derivJ2=0;
% for i=1:length(X)
%    derivJ0=(p_x(i,1)-Y(i,1))*X(i,1);
%    derivJ1=(p_x(i,1)-Y(i,1))*X(i,2);
%    derivJ2=(p_x(i,1)-Y(i,1))*X(i,3);
%    sum_derivJ0=sum_derivJ0+derivJ0;
%    sum_derivJ1=sum_derivJ1+derivJ1;
%    sum_derivJ2=sum_derivJ2+derivJ2;
% end
% gradient(1,1)=sum_derivJ0;
% gradient(2,1)=sum_derivJ1;
% gradient(3,1)=sum_derivJ2;
% 
% new_theta=theta-(tau*gradient);
counter=0;
dif=10;
while max(dif)>0.00001
[theta,cost,dif]=Theta_calc(tau,theta,X,Y);
counter=counter+1;
cost_v(counter)=cost;
end
X_plot(:,1)=ones(100,1);
X_plot(:,2)=linspace(4,7,100);
X_plot(:,3)=linspace(2,4.5,100);
X_2=((theta(1,1)/-theta(3,1))*X_plot(:,1))+((theta(2,1)/-theta(3,1))*X_plot(:,2));

figure (1)
plot(1:counter,cost_v);

figure(2)
scatter(X(1:50, 2), X(1:50, 3)); hold on
scatter(X(51:100, 2), X(51:100, 3)); hold on
plot(X_plot(:,2),X_2);
title('Linear Classification');

