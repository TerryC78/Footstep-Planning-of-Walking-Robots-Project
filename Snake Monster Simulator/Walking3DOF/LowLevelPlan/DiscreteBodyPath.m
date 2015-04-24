function [NewBodyPath] = DiscreteBodyPath(BodyPath, BodyCostMap)
%UNTITLED2 Summary of this function goes here
%   Discretize the body path according to the body cost map
%   For example, if the body cost of current position is high, then reduce
%   the step length. Otherwise, increase step length

    VariantStepLen = 0;
    
    [c1, ~] = size(BodyPath);
    if VariantStepLen == 0 % extract body path points evenly
        StepLenth = 10;
        idx = 1:StepLenth:c1; 
        NewBodyPath = BodyPath(idx, :);
        NewBodyPath(end+1, :) = BodyPath(end, :);
    else
        
    end
    


end

