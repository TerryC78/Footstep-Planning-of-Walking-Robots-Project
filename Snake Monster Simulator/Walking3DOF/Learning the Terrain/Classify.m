function [ y ] = Classify(W, feature)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [~, c2] = size(feature);
    W_rep = repmat(W, 1, c2);  % rep weights matrix
    % y = (2*(sum(W_rep .* feature) >= 0) - 1)';   % binary classification
    y = (sum(W_rep .* feature))';
    
end

