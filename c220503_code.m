load fisheriris.mat
sepal_length = meas(1:50, 1);
sepal_width = meas(1:50, 2);
petal_length = meas(1:50, 3);
tbl = table(sepal_length, sepal_width, petal_length);
mdl = fitlm(tbl,'sepal_length ~ sepal_width+petal_length');
plot(mdl)

% To do:
% 1. (At*A)*x=At*b --> solve (LSQ)
% 2. Find MSE both for the train and test subsets
% 3. Plot with manual change of weights to see what sjpae does MSE have
% (should be parabolic)
% 4. Plot different norms (L1, L2, Linfty)