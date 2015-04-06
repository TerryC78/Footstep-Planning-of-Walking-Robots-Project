function [idx] = search_parent(parent_node, OPEN)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    c1 = size(OPEN, 1); 
    idx = 0;
    for i = 1:c1
        if OPEN(i, 2:3) == parent_node
            idx = i;
            break;
        end
    end
    if 0 == idx
        error('not find parent\n');
    end
end