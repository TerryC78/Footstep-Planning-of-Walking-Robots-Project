function [rob_mat, idx, flag] = find_next(OPEN)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% delete those nodes which are not in OPEN
c1 = size(OPEN, 1);
for i = 1:c1
    if OPEN(i, 1) == 0
        OPEN(i, 8) = inf;
    end
end

% use min function to find the row number which has the lowest fn
[fn_min, idx] = min(OPEN(:, 8));

if fn_min == inf
    rob_mat = [0, 0];
    flag = 0; % can't find next node
else
    rob_mat = OPEN(idx, 2:3); % output the idx
    flag = 1; % successfully find node
end

end

