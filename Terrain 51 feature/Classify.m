function [ y ] = Classify(W, feature)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [c1, c2] = size(feature);
    W_tmp = repmat(W, 1, c2);
    y = (2*(sum(W_tmp .* feature(1:51,:)) >= 0) - 1)';
    
end

