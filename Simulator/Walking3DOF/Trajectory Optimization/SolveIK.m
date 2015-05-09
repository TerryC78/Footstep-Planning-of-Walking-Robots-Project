function [JointAngles] = SolveIK(MoreFootStep)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    [~, ~, m3] = size(MoreFootStep);
    JointAngles = zeros(3, 6, m3);
    
    for i = 1:m3
        JointAngles(1:3, 1, i) = IK(MoreFootStep(:, 1, i)');
        JointAngles(1:3, 2, i) = IK(MoreFootStep(:, 2, i)');
        JointAngles(1:3, 3, i) = IK(MoreFootStep(:, 3, i)');
        JointAngles(1:3, 4, i) = IK(MoreFootStep(:, 4, i)');
        JointAngles(1:3, 5, i) = IK(MoreFootStep(:, 5, i)');
        JointAngles(1:3, 6, i) = IK(MoreFootStep(:, 6, i)');
    end

end

