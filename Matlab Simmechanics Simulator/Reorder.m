function [x1_new, y1_new, x2_new, y2_new] = Reorder(x1, y1, x2, y2)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    if x1 <= x2
        x1_new = x1;
        x2_new = x2;
    else
        x1_new = x2;
        x2_new = x1;
    end
    
    if y1 <= y2
        y1_new = y1;
        y2_new = y2;
    else
        y1_new = y2;
        y2_new = y1;
    end
end

