function [ dist ] = distance( x1, y1, x2, y2 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    tmp1 = x1 - x2;
    tmp2 = y1 - y2;
    
    dist = sqrt((tmp1*tmp1) + (tmp2*tmp2));

end

