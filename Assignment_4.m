
%  POLYNOMIAL REGRESSION WITH d = 2 AND REGULARIZATION
% ========================================================================

clear all; close all; clc;

load('Assignment2data.mat');

% % Value of w (minimum error slope for y = w*x and l2)
% for lambda = 1:4:12
%     w(lambda) = (A'*A+lambda*eye(size(A,2)))\(A'*b);
%     wd2(:,lambda) = (Ad2'*Ad2+lambda*eye(size(Ad2,2)))\(Ad2'*b);
%     wd3(:,lambda) = (Ad3'*Ad3+lambda*eye(size(Ad3,2)))\(Ad3'*b);
%     wd4(:,lambda) = (Ad4'*Ad4+lambda*eye(size(Ad4,2)))\(Ad4'*b);
% end
% % fprintf('w (linear) = %.8f \n\n',w);
% % fprintf('w0 (affine) = %.6f \n',wd2(1));
% % fprintf('w1 (affine) = %.8f \n\n',wd2(2));
% % fprintf('w0 (quadratic) = %.4f \n',wd3(1));
% % fprintf('w1 (quadratic) = %.6f \n',wd3(2));
% % fprintf('w2 (quadratic) = %.6f \n\n',wd3(3));
% % fprintf('w0 (cubic) = %.4f \n',wd4(1));
% % fprintf('w1 (cubic) = %.6f \n',wd4(2));
% % fprintf('w2 (cubic) = %.6f \n',wd4(3));
% % fprintf('w3 (cubic) = %.6f \n\n',wd4(4));

% MSE for different sections of test and train data (20% - 80%) with
% variation of the regularization parameter (lambda)
test_length = 0.2*length(Assignment2data);
train_length = 0.8*length(Assignment2data);
A_test = zeros(test_length,5);
b_test = zeros(test_length,5);
test_positions = zeros(test_length,5);
A_train = zeros(train_length,5);
b_train = zeros(train_length,5);
p = 1;
m = 1;
for i = 1:5
    % Test matrix generation
    last_point_test = test_length*i;
    first_point_test = last_point_test-(test_length-1);
    for j = first_point_test:last_point_test
        A_test(m,i) = Assignment2data(j,1);
        b_test(m,i) = Assignment2data(j,2);
        test_positions(m,i) = j;
        m = m+1;
    end
    m = 1;
    % Train matrix generation
    for e = 1:length(Assignment2data)
        if e ~= test_positions(:,i)
            A_train(p,i) = Assignment2data(e,1);
            b_train(p,i) = Assignment2data(e,2);
            p = p+1;
        end
    end
    p = 1;
end
lambda = logspace(-15,5,100);
var_train = zeros(i, length(lambda));
var_test = zeros(i, length(lambda));
for k = 1:length(lambda)
    for i = 1:5
        % Train part
        Ad2_train(:,:,i) = [ones(train_length,1) A_train(:,i)];
        wd2(:,i,k) = (Ad2_train(:,:,i)'*Ad2_train(:,:,i)+lambda(k)*eye...
            (size(Ad2_train(:,:,i),2)))\(Ad2_train(:,:,i)'*b_train(:,i));
        affine_train(:,i,k) = wd2(1,i,k)+wd2(2,i,k)*A_train(:,i);
        ed2_train_total = 0;
        theta_m = mean(b_train(:,i));
        for e = 1:train_length
            ed2_train = (affine_train(e,i,k)-b_train(e,i))^2;
            ed2_train_total = ed2_train_total+ed2_train;
            var_train(i, k) = var_train(i, k)+(ed2_train - theta_m)^2;
        end
        MSEd2_train(i,k) = (1/train_length)*ed2_train_total;
        var_train(:, i, k) = var_train(:, i, k)/train_length;
        % Test part
        affine_test(:,i,k) = wd2(1,i,k)+wd2(2,i,k)*A_test(:,i);
        ed2_test_total = 0;
        theta_m = mean(b_test(:,i));
        for e = 1:test_length
            ed2_test = (affine_test(e,i,k)-b_test(e,i))^2;
            ed2_test_total = ed2_test_total+ed2_test; 
            var_test(i, k) = vart_test(i, k)+(ed2_test - theta_m)^2;
        end
        MSEd2_test(i,k) = (1/test_length)*ed2_test_total;
        var_test(i, k) = var_test(i, k)/test_length;
    end
    MSEd2_train_average(k) = mean(MSEd2_train(:,k));
    MSEd2_train_max(k) = max(MSEd2_train(:,k));
    MSEd2_train_min(k) = min(MSEd2_train(:,k));
    MSEd2_test_average(k) = mean(MSEd2_test(:,k));
    MSEd2_test_max(k) = max(MSEd2_test(:,k));
    MSEd2_test_min(k) = min(MSEd2_test(:,k));
end

% Scatter graph of data and regression lines
x = 155:1:200;
i = 1;
k = 1;
affine = wd2(1,i,k)+wd2(2,i,k)*x;
figure('Position',[550 550 800 400]);
hold on;
scatter(A_train(:,i),b_train(:,i));
scatter(A_test(:,i),b_test(:,i),'rx');
plot(x,affine);
ylim([40 110]);
title('Weight vs Height of 100 office workers');
xlabel('Height (cm)'); ylabel('Weight (kg)');
legend('Train data','Test data','Affine regression','Location',...
    'southeast');

% Graph of average MSE vs lambda

figure('Position',[550 50 800 400]);
figure()
errorbar(lambda, MSEd2_train_average, var_train);
figure()
errorbar(lambda, MSEd2_test_average, var_test);
hold off
semilogx(lambda,MSEd2_train_average,'b',lambda,MSEd2_test_average,'r')%,...
%     lambda,MSEd2_train_max,'b:',lambda,MSEd2_train_min,'b:',...
%     lambda,MSEd2_test_max,'r:',lambda,MSEd2_test_min,'r:');
% patch([lambda fliplr(lambda)], [MSEd2_train_max ...
%     fliplr(MSEd2_train_min)],'b','FaceAlpha',0.3,'LineStyle','none');
% patch([lambda fliplr(lambda)], [MSEd2_test_max ...
%     fliplr(MSEd2_test_min)],'r','FaceAlpha',0.3,'LineStyle','none');
grid; grid minor;
title('MSE vs \lambda');
xlabel('\lambda'); ylabel('MSE');
legend('Train data','Test data','Location','northeast');


