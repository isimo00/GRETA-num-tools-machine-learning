function [test_X, test_Y, train_X, train_Y] = split(X, Y, idx, test_size)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% len (x) = len (Y)
 test_X = X(idx(1:length(X)*test_size));
 test_Y = Y(idx(1:length(X)*test_size));

 train_X = X(idx(length(X)*test_size+1:end));
 train_Y = Y(idx(length(X)*test_size+1:end));
end