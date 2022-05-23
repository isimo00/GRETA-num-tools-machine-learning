function [y, w] = poly_prediction(A_in,b,d,lambda)
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
%   w = Weights vector [d, 1]
%   y = predicted values [m, 1]

if ~exist('lambda','var')
     % If parameter lambda does not exist, default value is 0
      lambda = 0;
 end

A = zeros(length(A_in), d);
for dd=1:d
    A(:, dd) = A_in(:, 1).^dd;
end

% L1
[n, m] = size(A);
X  = linprog([zeros(m, 1); ones(n, 1)],[A, -eye(n); -A, -eye(n)], [b; -b]);
w1= X(1:m);
y1 = A*w1;

% L2
w = (A.'*A + lambda(k)*eye(d))\(A.'*b);
y = A*w;

% Linfty
f = [zeros(m, 1); 1];
Ane = [A, -ones(n, 1); -A, -ones(n, 1)];
bne = [b; -b];
X = linprog(f, Ane, bne);
Xinfty = X(1:m, :);
end