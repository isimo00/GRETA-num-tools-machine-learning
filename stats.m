function [MSE, Var, Theta_m] = stats(y,b)
% Irene Simo Munoz
% May 23rd 2022
% Function that computes the MSE and variance of the given vectors
% INPUTS:
%   y: predicted values [m, 1].
%   b: Column vector, reference values [m, 1]. Must be a one-column vector.
% OUTPUTS:
%   MSE = MSE error
%   Var = Variance
%   Theta_m = Empirical mean

Theta_m = mean(y, 1);
var_elements = zeros(length(y), 1);
for i=1:length(y)
    var_elements = (y(i)-Theta_m)^2;
end
Var = 1/length(y)*sum(var_elements);

MSE = 1/length(y)*sum((y-b).^2);
end