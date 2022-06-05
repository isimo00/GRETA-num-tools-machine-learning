function [y_train, y_test, w] = poly_prediction(A_in, b, A_test_in, d,lambda)
% Irene Simo Munoz
% May 23rd 2022
% Function that performs any polynomial regression for provided data
% INPUTS:
%   A_in: Desing matrix [m, n]. First column must be plain data. Only the
%   first column will be used.
%   b: Column vector, reference values [m, 1]. Must be a one-column vector.
%   d: Degree of the resulting polynomial
%
% OUTPUTS:
%   w = Weights vector [d, 3]
%   y = predicted values [m, 3]
%   Each column is a different norm; 1 is L1; 2 is L2 and 3 is L infty

if ~exist('lambda','var')
     % If parameter lambda does not exist, default value is 0
      lambda = 0;
 end

A = zeros(length(A_in), d);
A_test = zeros(length(A_test_in), d);
for dd=0:d
    A(:, dd+1) = A_in(:, 1).^dd;
    A_test(:, dd+1) = A_test_in(:, 1).^dd;
end

[n, m] = size(A);

% L1
X  = linprog([zeros(m, 1); ones(n, 1)],[A, -eye(n); -A, -eye(n)], [b; -b]);
w(:, 1)= X(1:m);
y_train(:, 1) = A*w(:, 1);
y_test(:, 1) = A_test*w(:, 1);

% L2
w(:, 2) = (A.'*A + lambda*eye(d+1))\(A.'*b);
y_train(:, 2) = A*w(:, 2);
y_test(:, 2) = A_test*w(:, 2);

% Linfty
f = [zeros(m, 1); 1];
Ane = [A, -ones(n, 1); -A, -ones(n, 1)];
bne = [b; -b];
X = linprog(f, Ane, bne);
Xinfty = X(1:m, :);
w(:, 3) = Xinfty;
y_train(:, 3) = A*Xinfty;
y_test(:, 3) = A_test*Xinfty;
end