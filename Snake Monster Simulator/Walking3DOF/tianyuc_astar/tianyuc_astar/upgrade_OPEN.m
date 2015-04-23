function [OPEN] = upgrade_OPEN(OPEN, OPEN_candidate, idx1, f3)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if f3 == 1
    c1 = size(OPEN_candidate, 1);
    c2 = size(OPEN, 1);
    cnt = c2 + 1;
    % first search if there are same rows in OPEN and OPEN_candidate
    for i = 1:c1
        flag = 0; 
        for j = 1:c2
            if (OPEN_candidate(i, 2) == OPEN(j, 2) && OPEN_candidate(i, 3) == OPEN(j, 3))
                % true, then compare cost value
                if OPEN_candidate(i, 8) < OPEN(j, 8)
%                   OPEN(j, 1) = 0; % delete node
                    OPEN(j, :) = OPEN_candidate(i, :);
%                   cnt = cnt + 1;
                end  
                flag = 1;
            end
        end
        if flag == 0
            % then add it into OPEN
            OPEN(cnt, :) = OPEN_candidate(i, :);
            cnt = cnt + 1;
        end
    end
end
OPEN(idx1, 1) = 0;
end

