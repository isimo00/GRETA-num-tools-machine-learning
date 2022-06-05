clear all

data = dlmread('data.txt');
X = data(:, 3);
Y = data(:, 1);
% utau_good = data(:, 5);
scatter(X, Y);
%begin function cross validation

num_of_runs = 2;
max_deg = 7;
test_size = 0.2;

Y_t = zeros(length(data)*test_size, max_deg+1, 3);
W = zeros(max_deg+1, max_deg+1, 3);

%% Polynomial basis
for sim = 1:num_of_runs % Monte Carlo simulating
    idx = randperm(length(data));
    [test_X, test_Y, train_X, train_Y] = split(X, Y, idx, test_size);

    for deg = 0:max_deg
        [y0_train, y0_test, w0] = poly_prediction(train_X, train_Y, test_X, deg);
        [MSE_train, Var_train, Theta_m_train] = stats(y0_train, train_Y);
        [MSE_test, Var_test, Theta_m_test] = stats(y0_test, test_Y);
%         for lambda = ;
%             [y, w] = poly_prediction(A_in,b,deg, lambda);
%         end
        for L=1:3
            Y_t(:, deg+1, L) = Y_t(:, deg+1, L) + y0_test(:, L); %L1, y0_test(:, 2) for L2
            W(1:deg+1, deg+1, L) = W(1:deg+1, deg+1, L) + w0(:, L);
        end
    end
    
end

%% Averaging
for L=1:3
    Y_t(:, :, L) = Y_t(:, :, L)./num_of_runs;
    W(:, :, L) = W(:, :, L)./num_of_runs;
end

figure()
pl = sortrows([test_X, y0_test(:, 1)]);
pl_avg = sortrows([test_X, Y_t(:, 8, 1)]);
scatter(test_X, test_Y); hold on
plot(pl(:,1),pl(:,2), linewidth=2); hold on
plot(pl_avg(:,1),pl_avg(:,2), linewidth=2);

%% Non-polynomial basis?

clearvars data