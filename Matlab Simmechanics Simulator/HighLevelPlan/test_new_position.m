function [ flag ] = test_new_position( i, j, rob_mat, obs_mat, map )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    flag = 1;
    c1 = size(obs_mat, 1);
    [x_map y_map] = size(map);
    tmp1 = rob_mat(1) + i;
    tmp2 = rob_mat(2) + j; % new position
    if tmp1 < 1 || tmp1 > x_map || tmp2 < 1 || tmp2 > y_map % whether exceeds the map
        flag = 0;
    end
    for c2 = 1:c1  % check obstacle
        if tmp1 == obs_mat(c2, 1) && tmp2 == obs_mat(c2, 2)
            flag = 0; 
            break;
        end
    end
end

