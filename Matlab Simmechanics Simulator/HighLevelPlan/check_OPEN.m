function [flag, idx] = check_OPEN(OPEN, tar_mat)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    c1 = size(OPEN, 1);
    idx = 0;
    flag = 0; % doesn't reach the target position
    for i = 1:c1
        if OPEN(i, 2:3) == tar_mat
            idx = i;
            flag = 1;
            break;
        end
    end
end

