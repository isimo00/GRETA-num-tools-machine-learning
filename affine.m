function [y, w] = affine(A_in,b)
% Irene Simo Munoz
% May 23rd 2022
% Function that performs an affine regression for provided data
% INPUTS:
%   A_in: Desing matrix [m, n]. First column must be plain data. Only the
%   first column will be used.
%   b: Column vector, reference values [m, 1]. Must be a one-column vector.
% OUTPUTS:
%   w = Weights vector [2, 1]
%   y = predicted values [m, 1]

A = zeros(length(A_in), 2);
A(:, 1) = ones(length(A_in), 1);
A(:, 2) = A_in;
w = A\b;
y = A*w;
end