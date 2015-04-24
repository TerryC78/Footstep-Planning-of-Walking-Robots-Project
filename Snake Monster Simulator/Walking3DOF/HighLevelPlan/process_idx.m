function [idx] = process_idx(idx)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
%     if tmp(1) > 1;
        [m, n] = size(idx);
        for i = 1:m
            if idx(i, 1) == 1
                idx = i;
                break;
            end
        end
%     end
end

