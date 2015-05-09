function [rob_path] = path(OPEN, idx, rob_mat)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%   tmp = zeros(1, 2);
    count = 1;
    rob_path = zeros(1, 2); 
    while (OPEN(idx, 2) ~= rob_mat(1) || OPEN(idx, 3) ~= rob_mat(2))
        rob_path(count, :) = OPEN(idx, 2:3); % add path
        idx = search_parent(OPEN(idx, 4:5), OPEN);  % update idx
        count = count + 1;
    end
    rob_path(count, :) = rob_mat; % starting node
end

