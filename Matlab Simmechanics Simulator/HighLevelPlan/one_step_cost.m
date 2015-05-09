function [ cost ] = one_step_cost(rob_mat, i, j)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    cost = zeros(1, 3);
    cost(1) = sqrt(i*i + j*j);
    cost(2) = i;
    cost(3) = j;
end

