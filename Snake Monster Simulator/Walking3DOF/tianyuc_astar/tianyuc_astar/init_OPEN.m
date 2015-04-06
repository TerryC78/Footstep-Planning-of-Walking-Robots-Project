function [ cost_arr ] = init_OPEN( rob_mat, tar_mat )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    % rob_mat: 1*2  tar_mat: 1*2
    cost_arr = zeros(1, 8);
    cost_arr(1) = 1; % in the list
    % 4 positions
    cost_arr(2) = rob_mat(1);
    cost_arr(3) = rob_mat(2);
    cost_arr(4) = rob_mat(1);
    cost_arr(5) = rob_mat(2);
    
    % hn --- cost of travaling to the node
    % gn --- distance between current node and the goal
    % fn --- sum of hn and gn
    cost_arr(6) = 0;  % 
    cost_arr(7) = distance(rob_mat(1), rob_mat(2), tar_mat(1), tar_mat(2));
    cost_arr(8) = cost_arr(6) + cost_arr(7);
    
end

