function [flag] = process_obs(obs_mat, tar_mat, rob_mat)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    c1 = size(obs_mat, 1);
    flag = 0;
    for i = 1:c1
        if (obs_mat(i, 1) == tar_mat(1) && obs_mat(i, 2) == tar_mat(2)) ||...
           (obs_mat(i, 1) == rob_mat(1) && obs_mat(i, 2) == rob_mat(2))
            flag = 1;
            break;
        end
    end
end

